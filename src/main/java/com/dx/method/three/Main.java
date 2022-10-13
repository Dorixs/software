package com.dx.method.three;

/**
 * @ClassName Main
 * @Description
 * @Author dx
 * @Date 2022/10/12 21:03
 */
public class Main {
    public static void start3(String fileName) {
        //创建主题
        KWICSubject kwicSubject = new KWICSubject();
        //创建观察者
        Input input = new Input(fileName);
        Shift shift = new Shift(input.getLineTxt());
        Alphabetizer alphabetizer = new Alphabetizer(shift.getKwicList());
        Output output = new Output(alphabetizer.getKwicList(), "E:\\output.txt");

        // 将观察者加入主题
        kwicSubject.addObserver(input);
        kwicSubject.addObserver(shift);
        kwicSubject.addObserver(alphabetizer);
        kwicSubject.addObserver(output);
        // 逐步调用各个观察者
        kwicSubject.startKWIC();
    }
}
