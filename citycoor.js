function citycoor(person){
	if (person.info.birthnotes != null){
		var birthplace = person.info.birthnotes.toString() ;
		print(JSON.stringify(person));
		var infos = birthplace.split(/[,]+/);
		//var y = null;
		for (var city in infos){
			//print(JSON.stringify(birthplace));
			var query =	db.cities.find(
			  			{"name" : infos[city].trim()}, 
			  			{"_id":0,"name":1,"location":1}		    
				).toArray().map(function(o){print(JSON.stringify(o, null, 2));return 0;});
			if (query != null){
				break;
			}
		}
	} 
	return 0;
}
//print(usctosi("5' 1 1/4"))
