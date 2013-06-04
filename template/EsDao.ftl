package ${pagekage};

import org.elasticsearch.index.query.BoolFilterBuilder;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.BoolQueryParser;
import org.elasticsearch.index.query.FieldQueryBuilder;
import org.elasticsearch.index.query.RangeFilterBuilder;
import org.elasticsearch.index.query.RangeQueryBuilder;


import static org.elasticsearch.index.query.FilterBuilders.*;
import static org.elasticsearch.index.query.QueryBuilders.*;

import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.index.query.BoolFilterBuilder;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.RangeFilterBuilder;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.search.sort.SortOrder;

import org.apache.commons.lang.StringUtils;

/**
 * @Description: 为elasticSearch自动生成的简易查询类。
 * @author: zhaoziqiang@opzoon.com
 * @gentime: ${time}
 */
public class ${class?cap_first} {

	private static final String index = "${index}";
	private String types	= "";
	private Client client ;
	
	<#list fields as field>
	private ${field.type?cap_first} ${field.name};
	private String _${field.name} = "${field.name}";
  </#list>
	
	public ${class?cap_first}(final Client client){
		this.client = client;
	}
	
		public String getIndex(){
      return index;
    }
    
    public ${class?cap_first} setType(String types){
      this.types = types;
      return this;
    }
    
    public String getType(){
    	return this.types;
    }
    
	<#list fields as field>
    public ${field.type?cap_first} get${field.name?cap_first}(){
      return ${field.name};
    }
    public ${class?cap_first} set${field.name?cap_first}(${field.type?cap_first} ${field.name}){
      this.${field.name} = ${field.name};
      return this;
    }
  </#list>
    
    public XboolQuery createXboolQuery(){
    	return new XboolQuery();
    }
    
    public XboolFilter createXboolFilter(){
    	return new XboolFilter();
    }
    
    
    protected class XboolQuery{
    	private SearchRequestBuilder srb = client.prepareSearch(index);
    	private BoolQueryBuilder bqb;
    	
    	public XboolQuery(){
    		this.bqb = boolQuery();
    	}
    	
    	<#list fields as field>
  
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，支持range。
    	 * @param qt
    	 * @param rqb
    	 * @return XboolQuery   
    	 * @throws:
    	 */
    	protected XboolQuery must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb){
    		switch (qt) {
			case TERM:
				this.bqb.must(termQuery(_${field.name}, ${field.name}));
				break;
			case WILDCARD:
				this.bqb.must(wildcardQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case PERFIX:
				this.bqb.must(prefixQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case RANGE:
				if(rqb!=null)
					this.bqb.must(rqb);
				break;
			case TEXT:
				this.bqb.must(fieldQuery(_${field.name}, ${field.name}));
				break;
			default:
				break;
			}
    		return this;
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，QueryType为RANGE时请使用must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法。
    	 * @param qt
    	 * @return XboolQuery   
    	 * @throws:
    	 */
    	protected XboolQuery must${field.name?cap_first}(QueryType qt){
    		return must${field.name?cap_first}(qt,null);
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}Range</br>
    	 * <b>Description:</b> 为${field.name?cap_first}创建range，之后可通过must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法将之添加到boolQuery中。
    	 * @return RangeQueryBuilder   
    	 * @throws:
    	 */
    	protected RangeQueryBuilder must${field.name?cap_first}Range(){
    		return rangeQuery(_${field.name});
    	}
    	
    	//==============================================//
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，支持range。
    	 * @param qt
    	 * @param rqb
    	 * @return XboolQuery   
    	 */
    	protected XboolQuery should${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb){
    		switch (qt) {
			case TERM:
				this.bqb.should(termQuery(_${field.name}, ${field.name}));
				break;
			case WILDCARD:
				this.bqb.should(wildcardQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case PERFIX:
				this.bqb.should(prefixQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case RANGE:
				if(rqb!=null)
					this.bqb.should(rqb);
				break;
			case TEXT:
				this.bqb.should(fieldQuery(_${field.name}, ${field.name}));
				break;
			default:
				break;
			}
    		return this;
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，QueryType为RANGE时请使用must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法。
    	 * @param qt
    	 * @return XboolQuery   
    	 * @throws:
    	 */
    	protected XboolQuery should${field.name?cap_first}(QueryType qt){
    		return should${field.name?cap_first}(qt,null);
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}Range</br>
    	 * <b>Description:</b> 为${field.name}创建range，之后可通过must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法将之添加到boolQuery中。
    	 * @return RangeQueryBuilder   
    	 * @throws:
    	 */
    	protected RangeQueryBuilder should${field.name?cap_first}Range(){
    		return rangeQuery(_${field.name});
    	}
    	
    	//===================================================//
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，支持range。
    	 * @param qt
    	 * @param rqb
    	 * @return XboolQuery   
    	 * @throws:
    	 */
    	protected XboolQuery mustNot${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb){
    		switch (qt) {
			case TERM:
				this.bqb.mustNot(termQuery(_${field.name}, ${field.name}));
				break;
			case WILDCARD:
				this.bqb.mustNot(wildcardQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case PERFIX:
				this.bqb.mustNot(prefixQuery(_${field.name}, String.valueOf(${field.name})));
				break;
			case RANGE:
				if(rqb!=null)
					this.bqb.mustNot(rqb);
				break;
			case TEXT:
				this.bqb.mustNot(fieldQuery(_${field.name}, ${field.name}));
				break;
			default:
				break;
			}
    		return this;
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}</br>
    	 * <b>Description:</b> 添加${field.name}到boolQuery，QueryType为RANGE时请使用must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法。
    	 * @param qt
    	 * @return XboolQuery   
    	 * @throws:
    	 */
    	protected XboolQuery mustNot${field.name?cap_first}(QueryType qt){
    		return mustNot${field.name?cap_first}(qt,null);
    	}
    	/**
    	 * <b>Title:</b> must${field.name?cap_first}Range</br>
    	 * <b>Description:</b> 为${field.name}创建range，之后可通过must${field.name?cap_first}(QueryType qt,RangeQueryBuilder rqb)方法将之添加到boolQuery中。
    	 * @return RangeQueryBuilder   
    	 * @throws:
    	 */
    	protected RangeQueryBuilder mustNot${field.name?cap_first}Range(){
    		return rangeQuery(_${field.name});
    	}
    	//=============================================//
    	</#list>
    	protected XboolQuery boost(float boost){
    		this.bqb.boost(boost);
    		return this;
    	}
    		
    	public BoolQueryBuilder getQuery(){
    		return this.bqb;
    	}
    	
    	public XboolQuery setType(){
    		this.srb.setTypes(types);
    		return this;
    	}
    	
    	public XboolQuery setTypes(String... types){
    		this.srb.setTypes(types);
    		return this;
    	}
    	
    	public SearchResponse search(int size,int from,String sortField,SortOrder order){
    		this.srb.setQuery(this.bqb);
    		if(size>0)	srb.setFrom(from);
    		if(from>0)	srb.setSize(size);
    		if(StringUtils.isNotBlank(sortField) && order!=null)	srb.addSort(sortField, order);
    		return srb.execute().actionGet();
    	}
    	
    	public SearchResponse search(int size,int from){
    		return search(size, from, null, null);
    	}
    	
    	public SearchResponse search(){
    		return search(0, 0, null, null);
    	}
	
    }
    
    protected class XboolFilter{
    	
    	private SearchRequestBuilder srb = client.prepareSearch(index);
    	private BoolFilterBuilder bfb;
    	
    	public XboolFilter(){
    		this.bfb = boolFilter();
    	}
    	<#list fields as field>
    	protected XboolFilter must${field.name?cap_first}(FilterType ft,RangeFilterBuilder rfb){
    		switch (ft) {
			case TERM_FILTER:
				this.bfb.must(termFilter(_${field.name}, ${field.name}));
				break;
			case PERFIX_FILTER:
				this.bfb.must(prefixFilter(_${field.name}, String.valueOf(${field.name})));
				break;
			case QUERY_FILTER:
				this.bfb.must(queryFilter(fieldQuery(_${field.name}, ${field.name})));
			case RANGE_FILTER:
				this.bfb.must(rfb);
				break;
			default:
				break;
			}
    		return this;
    	}
    	
    	protected XboolFilter must${field.name?cap_first}(FilterType ft){
    		return must${field.name?cap_first}(ft,null);
    	}
    	
    	protected RangeFilterBuilder must${field.name?cap_first}Range(){
    		return rangeFilter(_${field.name});
    	}
    	
    	//==============================================//
    	
    	protected XboolFilter should${field.name?cap_first}(FilterType ft,RangeFilterBuilder rfb){
    		switch (ft) {
			case TERM_FILTER:
				this.bfb.should(termFilter(_${field.name}, ${field.name}));
				break;
			
			case PERFIX_FILTER:
				this.bfb.should(prefixFilter(_${field.name}, String.valueOf(${field.name})));
			case RANGE_FILTER:
				if(rfb!=null)
					this.bfb.should(rfb);
			case QUERY_FILTER:
				this.bfb.should(queryFilter(fieldQuery(_${field.name}, ${field.name})));
			default:
				break;
			}
    		return this;
    	}
    	
    	protected XboolFilter should${field.name?cap_first}(FilterType ft){
    		return should${field.name?cap_first}(ft,null);
    	}
    	
    	protected RangeFilterBuilder should${field.name?cap_first}Range(){
    		return rangeFilter(_${field.name});
    	}
    	
    	//===================================================//
    	
    	protected XboolFilter mustNot${field.name?cap_first}(FilterType ft,RangeFilterBuilder rfb){
    		switch (ft) {
			case TERM_FILTER:
				this.bfb.mustNot(termFilter(_${field.name}, ${field.name}));
				break;
			case PERFIX_FILTER:
				this.bfb.mustNot(prefixFilter(_${field.name}, String.valueOf(${field.name})));
			case RANGE_FILTER:
				if(rfb!=null)
					this.bfb.mustNot(rfb);
			case QUERY_FILTER:
				this.bfb.mustNot(queryFilter(fieldQuery(_${field.name}, ${field.name})));
			default:
				break;
			}
    		return this;
    	}
    	
    	protected XboolFilter mustNot${field.name?cap_first}(FilterType ft){
    		return mustNot${field.name?cap_first}(ft,null);
    	}
    	
    	protected RangeQueryBuilder mustNot${field.name?cap_first}Range(){
    		return rangeQuery(_${field.name});
    	}
    	//=============================================//
    	</#list>
    	protected XboolFilter cache(boolean cache){
    		this.bfb.cache(cache);
    		return this;
    	}
    	public BoolFilterBuilder getFilter(){
    		return this.bfb;
    	}
    	
    	public XboolFilter setType(){
    		this.srb.setTypes(types);
    		return this;
    	}
    	
    	public XboolFilter setTypes(String... types){
    		this.srb.setTypes(types);
    		return this;
    	}
    	
    	public SearchResponse search(int size,int from,String sortField,SortOrder order){
    		SearchRequestBuilder srb = client.prepareSearch(index).setFilter(this.bfb);
    		if(size>0)	srb.setFrom(from);
    		if(from>0)	srb.setSize(size);
    		if(StringUtils.isNotBlank(sortField) && order!=null)	srb.addSort(sortField, order);
    		return srb.execute().actionGet();
    	}
    	
    	public SearchResponse search(int size,int from){
    		return search(size, from, null, null);
    	}
    	
    	public SearchResponse search(){
    		return search(0, 0, null, null);
    	}
    	
    }
    
    
    public static void main(String[] args) {
    	// 使用方法 modify it than test
    	/* 
		${class?cap_first} ${class} = new ${class?cap_first}(new TransportClient(ImmutableSettings.settingsBuilder()
        			.put("client.transport.sniff", false)
        			.put("cluster.name", cluster)
        			)
    		.addTransportAddress(new InetSocketTransportAddress(host, port)););
    		${class}.setXXX(...);
		SearchResponse sr = ${class}.createXboolQuery().mustXXX(QueryType.TEXT).search();
		System.out.println(sr.toString());
		*/
	}
}
