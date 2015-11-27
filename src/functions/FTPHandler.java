package functions;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import java.io.*;

public class FTPHandler {

    public static FTPClient ftpConnect() {

        FTPClient ftp = new FTPClient();
        String server = "www.ftpserver.com";
        String user = "username";
        String pass = "password";

        try {
            ftp.connect(server);
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            ftp.setFileTransferMode(FTP.BINARY_FILE_TYPE);
            ftp.setSoTimeout(10000);
            ftp.enterLocalPassiveMode();

            if (!FTPReply.isPositiveCompletion(ftp.getReplyCode())) {
                ftp.disconnect();
                System.err.println("FTP server refused connection.");
            } else {
                if (ftp.login(user, pass))
                    return ftp;
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (ftp.isConnected()) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {
                    // do nothing
                }
            }
        }
        return null;
    }

    public static boolean sendFile(File file) {
        FTPClient ftp = ftpConnect();

        if (ftp != null) {
            InputStream inputStream = null;

            try {
                inputStream = new FileInputStream(file);
                return ftp.storeFile(file.getName(), inputStream);

            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                if (inputStream != null)
                    try {
                        inputStream.close();
                        ftp.logout();
                        ftp.disconnect();
                    } catch (IOException e) {
                        System.out.println("Error: " + e.getMessage());
                        e.printStackTrace();
                    }
            }
        }
        return false;
    }

}
