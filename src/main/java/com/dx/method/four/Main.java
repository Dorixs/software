package com.dx.method.four;

import java.io.File;
import java.io.IOException;

/**
 * @ClassName Main
 * @Description
 * @Author dx
 * @Date 2022/10/12 21:10
 */
public class Main {
    public static void start4(String fileName) throws IOException {
        File inFile = new File(fileName);
        File outFile = new File("E:\\output.txt");
        Pipe pipe1 = new Pipe();
        Pipe pipe2 = new Pipe();
        Pipe pipe3 = new Pipe();
        Input input = new Input(inFile, pipe1);
        Shift shift = new Shift(pipe1, pipe2);
        Alphabetizer alphabetizer  = new Alphabetizer(pipe2, pipe3);
        Output output = new Output(outFile,pipe3);
        input.transform();
        shift.transform();
        alphabetizer.transform();
        output.transform();

    }
}

