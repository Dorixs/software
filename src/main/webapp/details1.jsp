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
<h2 style="text-align: center">主程序-子程序软件体系结构原理</h2>
<div style="width: 800px; margin: 20px auto; border: solid;">
    <h3 style="text-align: center;">原理图</h3>
    <img src="./img/img1.png" width="600px" height="400px;">
    <a href="index.jsp">
        <button style="height: 40px; width: 50px;">返回</button>
    </a>
    <hr>
    <h3 style="text-align: center;">代码</h3>
    <pre style="font-size: 20px; ">
       public class demo1 {
    private ArrayList<String> kwicList = new ArrayList<String>();
    private ArrayList<String> lineTxt = new ArrayList<String>();
    private BufferedReader inputFile;
    private BufferedWriter outputFile;

    public static void main(String[] args) {

        demo1 kwic = new demo1();
        kwic.input("E:\\input.txt");
        kwic.shift();
        kwic.alphabetizer();
        kwic.output("E:\\output.txt");
    }


    public void input(String fileName) {
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

    public void output(String filename){
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

    public void shift() {
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


    public void alphabetizer() {
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






      </pre>
</div>
</body>

</html>