function lookforinfo(person){
	var info = JSON.stringify(person.info, null, 2);
	if (info.indexOf("Opera") !== -1){
		print(JSON.stringify(person));
		print("Index of Opera", info.indexOf("Opera"));
	}
}
