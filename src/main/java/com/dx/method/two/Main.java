package com.dx.method.two;

/**
 * @ClassName Main
 * @Description
 * @Author dx
 * @Date 2022/10/12 20:58
 */
public class Main {
    public static void start2(String fileName) {
        Input input = new Input();
        input.input(fileName);
        Shift shift = new Shift(input.getLineTxt());
        shift.shift();
        Alphabetizer alphabetizer = new Alphabetizer(shift.getKwicList());
        alphabetizer.sort();
        Output output = new Output(alphabetizer.getKwicList());
        output.output("E:\\output.txt");

    }
}
