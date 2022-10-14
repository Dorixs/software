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
<h2 style="text-align: center">管道-过滤软件体系结构原理</h2>
<div style="width: 800px; margin: 20px auto; border: solid;">
    <h3 style="text-align: center;">原理图</h3>
    <img src="./img/img4.png" width="600px" height="400px;">
    <a href="index.jsp">
        <button style="height: 40px; width: 50px;">返回</button>
    </a>
    <hr>
    <h3 style="text-align: center;">代码</h3>
    <pre style="font-size: 20px; ">
    <h3 style="text-align: center;">Pipe管道类</h3>
        public class Pipe {
    private Scanner pipeReader;
    private PrintWriter pipeWriter;
    Pipe(){
        PipedWriter pipedWriter = new PipedWriter();
        PipedReader pipedReader = new PipedReader();
        try {
            pipedWriter.connect(pipedReader);
        } catch (IOException e) {
            e.printStackTrace();
        }
        pipeReader = new Scanner(pipedReader);
        pipeWriter = new PrintWriter(pipedWriter);
    }
    public String readerLine(){
        return pipeReader.nextLine();
    }
    public boolean hashNextLine(){
        return pipeReader.hasNext();
    }
    public void writerLine(String strLine){
        pipeWriter.println(strLine);
    }
    public void closeReader(){
        pipeReader.close();
    }
    public void closeWriter(){
        pipeWriter.close();
    }
}
   <h3 style="text-align: center;">Filter抽象类</h3>
      public abstract class Filter {
    protected Pipe input;
    protected Pipe output;

    public Filter(Pipe input, Pipe output) {
        this.input = input;
        this.output = output;
    }
    protected abstract void transform() throws IOException;
}
   <h3 style="text-align: center;">Input输入过滤器类</h3>
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
   <h3 style="text-align: center;">Shift单词移位过滤器类</h3>
        public class Shift extends Filter {

    public Shift(Pipe input, Pipe output) {
        super(input, output);
    }

    @Override
    protected void transform() throws IOException {
        //获取每个单词，存入tokens
        while (input.hashNextLine()) {
            StringTokenizer token = new StringTokenizer(input.readerLine());
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
                output.writerLine(tmp);
            }
        }
        input.closeReader();
        output.closeWriter();
    }
}
   <h3 style="text-align: center;">Alphabetizer排序过滤器类</h3>
       public class Alphabetizer extends Filter {
    private ArrayList<String> kwicList = new ArrayList<>();
    public Alphabetizer(Pipe input, Pipe output) {
        super(input, output);
    }

    @Override
    protected void transform() throws IOException {
        while (input.hashNextLine()){
            kwicList.add(input.readerLine());
        }
        Collections.sort(this.kwicList, new AlphabetizerComparator());
        for (String line:kwicList){
            output.writerLine(line);
        }
        input.closeReader();
        output.closeWriter();
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
    <h3 style="text-align: center;">Output输出过滤器类</h3>
    public class Output extends Filter {
    private File file;
    public Output(File file,Pipe input) {
        super(input, null);
        this.file = file;
    }

    @Override
    protected void transform() throws IOException {
        BufferedWriter outputFile =null;
        String line;
        try {
            outputFile = new BufferedWriter(new FileWriter(file));
            while (input.hashNextLine()) {
                outputFile.write(input.readerLine()+"\n");
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
        input.closeReader();
    }
}
    <h3 style="text-align: center;">Main类</h3>
     public class Main {
    public static void main(String[] args) throws IOException {
        File inFile = new File("E:\\input.txt");
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
      </pre>
</div>
</body>

</html>