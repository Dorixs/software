package com.dx.method.four;

import java.io.IOException;

/**
 * @ClassName Filter
 * @Description
 * @Author dx
 * @Date 2022/10/12 21:09
 */
public abstract class Filter {
    protected Pipe input;
    protected Pipe output;

    public Filter(Pipe input, Pipe output) {
        this.input = input;
        this.output = output;
    }
    protected abstract void transform() throws IOException;
}

