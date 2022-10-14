<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经典软件体系结构教学软件</title>
</head>
<body>
<h2 style="text-align: center">事件系统软件体系结构原理</h2>
<div style="width: 800px; margin: 20px auto; border: solid;">
    <h3 style="text-align: center;">原理图</h3>
    <img src="./img/img3.png" width="600px" height="400px;">
    <a href="index.jsp" ><button style="height: 40px; width: 50px;" >返回</button></a>
    <hr>
    <h3 style="text-align: center;">代码</h3>
    <pre style="font-size: 20px; ">
    <h3 style="text-align: center;">Subject抽象主题类</h3>
        public class Subject {

    //观察者数组
    private List<Observer> vector = new LinkedList<>();
    //增加一个观察者
    public void addObserver(Observer observer) {
        vector.add(observer);
    }
    //删除一个观察者
    public void deleteObserver(Observer observer) {
        vector.remove(observer);
    }
    //通知所有观察者
    public void notifyAllObserver() {
        for(Observer observer : vector) {
            observer.toDo();
        }
    }
    // 通知特定观察者
    public void notifyOneObserver(int i) {
        vector.get(i).toDo();
    }
}
  <h3 style="text-align: center;">KWIC具体主题类</h3>
  public class KWICSubject extends Subject{
    public void startKWIC(){
        for (int i = 0;i<3;i++){
            super.notifyOneObserver(i);
        }
    }
}
 <h3 style="text-align: center;">Observer抽象观察者类</h3>
   public interface Observer {
    void toDo();
}
  <h3 style="text-align: center;">Input 观察者类</h3>
     public class Input implements Observer{

    private ArrayList<String> lineTxt = new ArrayList<String>();

    public ArrayList<String> getLineTxt() {
        return lineTxt;
    }
    private String fileName;

    public Input(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void toDo() {
        BufferedReader inputFile = null;
        try {
            inputFile = new BufferedReader(new FileReader(fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
        String line;
        try {
            while ((line = inputFile.readLine()) != null) {
                lineTxt.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
   <h3 style="text-align: center;">Shift观察者类</h3>
     public class Shift implements Observer {
    private ArrayList<String> kwicList = new ArrayList<String>();
    private ArrayList<String> lineTxt;

    public Shift( ArrayList<String> lineTxt) {
        this.lineTxt = lineTxt;
    }

    public ArrayList<String> getKwicList() {
        return kwicList;
    }


    public ArrayList<String> getLineTxt() {
        return lineTxt;
    }

    @Override
    public void toDo() {
        //获取每个单词，存入tokens
        Iterator<String> it = lineTxt.iterator();
        while (it.hasNext()) {
            StringTokenizer token = new StringTokenizer(it.next());
            ArrayList<String> tokens = new ArrayList<String>();
            int i = 0;
            //循环添加单词
            int count = token.countTokens();
            while (i < count) {
                tokens.add(token.nextToken());
                i++;
            }

            //display(tokens);
            //切割各个单词，不断改变起始值和利用loop实现位移。
            for (i = 0; i < count; i++) {
                StringBuffer lineBuffer = new StringBuffer();
                int index = i;
                for (int f = 0; f < count; f++) {
                    //从头继续位移
                    if (index >= count)
                        index = 0;
                    //存入StringBuffer
                    lineBuffer.append(tokens.get(index));
                    lineBuffer.append(" ");
                    index++;
                }
                String tmp = lineBuffer.toString();
                kwicList.add(tmp);
            }
        }

    }

}
  <h3 style="text-align: center;">Alphabetizer 观察者类</h3>
     public class Alphabetizer implements Observer {
    private ArrayList<String> kwicList;

    public Alphabetizer(ArrayList<String> kwicList) {
        this.kwicList = kwicList;
    }

    public ArrayList<String> getKwicList() {
        return kwicList;
    }

    @Override
    public void toDo() {
        Collections.sort(this.kwicList, new AlphabetizerComparator());
    }

    private class AlphabetizerComparator implements Comparator<String> {
        @Override
        public int compare(String o1, String o2) {
            if (o1 == null && o2 == null) {
                throw new NullPointerException();
            }
            int compareValue = 0;
            char o1c = o1.toLowerCase().charAt(0); //忽略大小写
            char o2c = o2.toLowerCase().charAt(0); //忽略大小写
            compareValue = o1c - o2c;
            return compareValue;

        }

    }

}
  <h3 style="text-align: center;">Output观察类</h3>
     public class Output implements Observer {
    private ArrayList<String> kwicList;
    private BufferedWriter outputFile;
    private String filename;
    public Output(ArrayList<String> kwicList,String filename) {
        this.kwicList = kwicList;
        this.filename = filename;
    }

    @Override
    public void toDo(){
        Iterator<String> it = kwicList.iterator();
        try {
            outputFile = new BufferedWriter(new FileWriter(filename));
            while (it.hasNext()) {
                outputFile.write(it.next()+"\n");
            }
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            try {
                if (outputFile!=null) {
                    outputFile.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
  <h3 style="text-align: center;">测试类</h3>
      public class Main {
    public static void main(String[] args) {
        //创建主题
        KWICSubject kwicSubject = new KWICSubject();
        //创建观察者
        Input input = new Input("E:\\input.txt");
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

      </pre>
</div>
</body>

</html>