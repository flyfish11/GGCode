import java.io.File;

/**
 * <B>Description</B>  <br />
 * @author Wujianjun
 * @createTime 16/7/21 10:35
 */
public abstract class PreTemplateFile {
    protected File outRootDir;

    public PreTemplateFile(File outRootDir) {
        this.outRootDir = outRootDir;
    }

    public void beginProcess() {
        throw new UnsupportedOperationException();
    }

    public void finishProcess() {
        throw new UnsupportedOperationException();
    }

    public abstract boolean support();

    protected void deleteFile(File file) {
        if (!file.exists()) {
            return;
        }
        if (file.isFile()) {
            file.delete();
        }
        if (file.isDirectory()) {
            for (File fileK : file.listFiles()) {
                deleteFile(fileK);
            }
            file.delete();
        }
    }
}
