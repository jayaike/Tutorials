import java.io.File;
import java.io.IOException;
import java.util.Scanner;


public class ReadFileJava {
    public static void main(String[] args) throws IOException {
        try {
            readFile("<ABSOLUTE OR RELATIVE PATH HERE>");
        } catch(IOException err) {
            System.out.println(err.getMessage());
        }
    }

    public static void readFile(String filePath) throws IOException {
        // Declare a file with the given file path (can be relative or absolute)
        File file = new File(filePath);

        // Use the file as an input for the scanner class
        // which will enable us open and read its contents
        Scanner scnr = new Scanner(file);

        // While the txt file still has content (a new line in this case),
        // print out the next line
        while(scnr.hasNextLine()) {
            System.out.println(scnr.nextLine());
        }

        // Close the scanner and free up resources
        scnr.close();
    }
}
