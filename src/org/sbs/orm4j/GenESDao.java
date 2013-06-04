package org.sbs.orm4j;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.io.output.FileWriterWithEncoding;
import org.apache.commons.lang.StringUtils;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.cluster.ClusterState;
import org.elasticsearch.cluster.metadata.IndexMetaData;
import org.elasticsearch.cluster.metadata.MappingMetaData;
import org.elasticsearch.common.collect.ImmutableMap;
import org.elasticsearch.common.collect.ImmutableSet;
import org.elasticsearch.common.collect.Lists;
import org.elasticsearch.common.collect.UnmodifiableIterator;
import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;



public class GenESDao {

	private Map<String, Object> root = new HashMap<String, Object>();
	private Collection<Map<String, String>> fields = new HashSet<Map<String, String>>();
	private String index;
	private String className;
	private String host;
	private int port = 9300;
	private String $package;
	private String cluster;
	private String directory = "c:\\";

	public static void main(String[] args) throws IOException,
			TemplateException {
		GenESDao gen = new GenESDao();
		try {
			System.out.println("===========¿ªÊ¼=============");
			if (gen.parseCommandLine(args)) {
				gen.getEsMapping();
				gen.genEsDao();
			}
			System.out.println("===========½áÊø=============");
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private boolean parseCommandLine(String[] args) throws ParseException {
		Options options = new Options();
		options.addOption("H", "host", true, "hostname or ip of es host")
				.addOption("p", "port", true, "es port,default 9300.")
				.addOption("P", "package", true, "package.")
				.addOption("C", "cluster", true,
						"cluster name,default is \"elasticsearch\"")
				.addOption("c", "class", true,
						"class name,use index name if not set.")
				.addOption("i", "index", true, "index name")
				.addOption("d", "directory", true,
						"file directory,default is c:\\")
				.addOption("h", "help", false, "get help infomation");
		CommandLineParser parser = new GnuParser();
		CommandLine commandLine = parser.parse(options, args);
		if (commandLine.hasOption('h')) {
			HelpFormatter helpFormatter = new HelpFormatter();
			helpFormatter
					.printHelp(
							60,
							"orm4es",
							"example: java -jar transfer.jar -H 192.168.*.* -p 9300 -n Product -i product",
							options, "this is a orm tool for es.", true);
			// helpFormatter.printHelp("orm4es", options, true);
			return false;
		}
		if (!commandLine.hasOption("host")) {
			throw new ParseException(
					"You must specify a ip address to connect to with --host");
		}
		host = commandLine.getOptionValue("host");

		if (!commandLine.hasOption("index")) {
			throw new ParseException("You must specify index name --index");
		}
		index = commandLine.getOptionValue("index");

		if (commandLine.hasOption("port")) {
			port = Integer.parseInt(commandLine.getOptionValue("port"));
		}
		if (commandLine.hasOption("package")) {
			$package = commandLine.getOptionValue("package");
		}
		
		if (commandLine.hasOption("class")) {
			className = commandLine.getOptionValue("class");
		}
		if (commandLine.hasOption("cluster")) {
			cluster = commandLine.getOptionValue("cluster");
		}
		if (commandLine.hasOption("directory")) {
			directory = commandLine.getOptionValue("directory");
		}

		return true;
	}

	@SuppressWarnings("deprecation")
	public void getEsMapping() throws IOException {
		// get client
		Client client = null;
		if (StringUtils.isNotBlank(cluster)) {
			client = new TransportClient(ImmutableSettings.settingsBuilder()
					.put("client.transport.sniff", false)
					.put("cluster.name", cluster))
					.addTransportAddress(new InetSocketTransportAddress(host,
							port));
		}
		client = new TransportClient(ImmutableSettings.settingsBuilder().put(
				"client.transport.sniff", false))
				.addTransportAddress(new InetSocketTransportAddress(host, port));
		// types
		List<String> types = Lists.newArrayList();

		ClusterState cs = client.admin().cluster().prepareState()
				.setFilterIndices(index).execute().actionGet().getState();
		IndexMetaData imd = cs.getMetaData().index(index);
		ImmutableMap<String, MappingMetaData> mmds = imd.getMappings();
		ImmutableSet<Entry<String, MappingMetaData>> is = mmds.entrySet();
		for (UnmodifiableIterator<Entry<String, MappingMetaData>> iterator = is
				.iterator(); iterator.hasNext();) {
			Entry<String, MappingMetaData> entry = (Entry<String, MappingMetaData>) iterator
					.next();
			types.add(entry.getKey()); // collect type
			// mapping of type
			Map<String, Object> m = entry.getValue().getSourceAsMap();
			Set<Entry<String, Object>> set = m.entrySet();
			Iterator<Entry<String, Object>> it = set.iterator();
			while (it.hasNext()) {
				Entry<String, Object> en = (Entry<String, Object>) it.next();
				if ("properties".equals(en.getKey())) {
					@SuppressWarnings("unchecked")
					Map<String, Map<String, String>> properties = (Map<String, Map<String, String>>) en
							.getValue();
					Set<Entry<String, Map<String, String>>> p = properties
							.entrySet();
					for (Entry<String, Map<String, String>> e : p) {
						System.out.println(e.getKey() + " - "
								+ e.getValue().get("type"));
						Map<String, String> pro = e.getValue();
						pro.put("name", e.getKey());
						fields.add(pro);
					}
				}
			}
		}
		
		if(StringUtils.isBlank($package))
			$package = "org.sbs";
		root.put("pagekage", $package);

		if (StringUtils.isBlank(className))
			className = index;

		root.put("class", className);
		root.put("index", index);
		root.put("fields", fields);
		root.put("time", new Date().toLocaleString());
	}

	public void genEsDao() {
		Configuration cfg = new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File("template"));
			cfg.setObjectWrapper(new DefaultObjectWrapper());
			Template temp = cfg.getTemplate("EsDao.ftl");
			Writer out = new FileWriterWithEncoding(directory
					+ className.substring(0, 1).toUpperCase()
					+ className.substring(1) + ".java", "utf-8", false);
			temp.process(root, out);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}

}