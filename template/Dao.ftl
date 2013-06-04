package ${pagekage};

import org.springframework.stereotype.Repository;
import com.trendcom.dao.*;
import com.trendcom.model.*;

import static org.elasticsearch.index.query.FilterBuilders.*;
import static org.elasticsearch.index.query.QueryBuilders.*;

public class ${class} {

	private StringBuilder sb = new StringBuilder();
	
  <#list properties as prop>
	private ${prop.type} ${prop.name};
    private String _${prop.name} = "${prop.name}";
  </#list>
	
	public BoolQueryBuilder boolQuery(){
		return boolQuery();
	}
	
	public FieldQueryBuilder fieldQuery(){
		
	}
	
  <#list properties as prop>
    public ${prop.type} get${prop.name?cap_first}(){
      return ${prop.name};
    }
    public ${class} set${prop.name?cap_first}(${prop.type} ${prop.name}){
      this.${prop.name} = ${prop.name};
      return this;
    }
  </#list>
  
  

}
