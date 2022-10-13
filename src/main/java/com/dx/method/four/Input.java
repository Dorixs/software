package com.dx.method.four;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

/**
 * @ClassName Input
 * @Description
 * @Author dx
 * @Date 2022/10/12 21:09
 */
public class Input extends Filter {
    private File file;
    public Input(File file,Pipe output) {
        super(null, output);
        this.file = file;
    }

    @Override
    protected void transform() throws IOException {
        BufferedReader inputFile = null;
        try {
            inputFile = new BufferedReader(new FileReader(file));
        } catch (Exception e) {
            e.printStackTrace();
        }
        String line;
        try {
            while ((line = inputFile.readLine()) != null) {
                output.writerLine(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        output.closeWriter();
    }
}

