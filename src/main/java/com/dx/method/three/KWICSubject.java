package com.dx.method.three;

/**
 * @ClassName KWICSubject
 * @Description
 * @Author dx
 * @Date 2022/10/12 21:01
 */
public class KWICSubject extends Subject{
    public void startKWIC(){
        for (int i = 0;i<3;i++){
            super.notifyOneObserver(i);
        }
    }
}
