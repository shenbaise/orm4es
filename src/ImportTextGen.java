import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

/**
 * @project: testFreeMarkerGenCode
 * @Title: ImportTextGen.java
 * @Package 
 * @Description: 
 * @author: zhaoziqiang@opzoon.com
 * @date 2013-1-31 ����10:40:52
 * @version V1.0  
 */

/**
 * @ClassName: ImportTextGen
 * @Description: 
 * @author: zhaoziqiang@opzoon.com
 * @date 2013-1-31 ����10:40:52
 */
public class ImportTextGen {

	/**
	 * <b>Title:</b> main</br>
	 * <b>Description:</b> 
	 * @param args void   
	 * @throws:
	 * @author: zhaoziqiang@opzoon.com
	 * @date 2013-1-31 ����10:40:52
	 */
	public static void main(String[] args) {
		StringBuilder sb = new StringBuilder();
		File file = new File("c:\\m.txt");
		for(int i=0;i<1000;i++){
			
			sb.append("����-").append(i+1).append("\t")
			.append("2013-01-01 00:00:00").append("\t")
			.append("2013-03-01 10:12:13").append("\t")
			.append("ȫ��").append("\t")
			.append("a user").append("\t")
			.append("admin").append("\t")
			.append("MAC��ַ").append("\t")
			.append("100000000020\n")
			.append(" \t \t \t \t \t \tԴIP��ַ\t")
			.append("10.10.10.10\n")
			.append(" \t \t \t \t \t \tĿ��IP��ַ\t")
			.append("20.20.20.20\n")
			.append(" \t \t \t \t \t \t�����ʺ�\t")
			.append("15700000000\n")
			.append(" \t \t \t \t \t \tVLAN_ID\t")
			.append("1000\n")
			.append(" \t \t \t \t \t \t�����ʺ�\t")
			.append("��¼ID\n")
			.append(" \t \t \t \t \t \t�ؼ���\t")
			.append("standard").append(i+1).append("\n");
		}
		try {
			FileUtils.writeStringToFile(file, sb.toString(), "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}

