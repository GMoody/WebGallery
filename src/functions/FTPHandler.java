package functions;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class FTPHandler {
    // Тут надо перелопатить много!
    public static FTPClient ftpConnect() {
        try {
            FTPClient ftp = new FTPClient();
            ftp.connect("93.189.45.35");
            ftp.setFileType(FTP.BINARY_FILE_TYPE);
            ftp.setFileTransferMode(FTP.BINARY_FILE_TYPE);
            ftp.setSoTimeout(10000);
            ftp.enterLocalPassiveMode();

            if (ftp.login("g.tureev@gmail.com", "4a4612db")){
                return ftp;
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public static boolean sendFile(File file, boolean folder) {
        FTPClient ftp = ftpConnect();
        InputStream fis = null;

        if (ftp != null) {

            try {

                if(folder){ // folder avatars
                    ftp.changeWorkingDirectory("/public_http/avatars/");
                }else{ //folder pictures
                    ftp.changeWorkingDirectory("/public_http/pictures/");
                }

                fis = new FileInputStream(file);
                ftp.storeFile(file.getName(), fis);
                return true;

            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
                return false;
            } finally {
                if (fis != null)
                    try {
                        fis.close();
                        ftp.logout();
                        ftp.disconnect();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }
        return false;
    }

    public static boolean checkFile(File file, boolean folder){
        FTPClient ftp = ftpConnect();
        InputStream fis = null;

        if (ftp != null) {

            try {

                String filepath;

                if(folder){ // folder avatars
                    filepath = "/public_http/avatars/" + file.getName();
                }else{ //folder pictures
                    filepath = "/public_http/pictures/" + file.getName();
                }

                fis = ftp.retrieveFileStream(filepath);
                int returnCode = ftp.getReplyCode();
                return !(fis == null || returnCode == 550);

            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
                return false;
            } finally {
                if (fis != null)
                    try {
                        fis.close();
                        ftp.logout();
                        ftp.disconnect();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
            }
        }
        return true;
    }

    public static boolean removeFile(File file, boolean folder){
        FTPClient ftp = ftpConnect();

        if (ftp != null) {

            try {
                String filepath;

                if(folder){ // folder avatars
                    filepath = "/public_http/avatars/" + file.getName();
                }else{ //folder pictures
                    filepath = "/public_http/pictures/" + file.getName();
                }

                return ftp.deleteFile(filepath);

            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    ftp.logout();
                    ftp.disconnect();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return true;
    }

}
