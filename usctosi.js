function usctosi(person){
	const FEET_RATIO = parseFloat(30.48);
	const INCH_RATIO = parseFloat(2.54);
	var height = person.info.height.toString() ;
	//print("Taille initiale : ", height);
	if (height.indexOf("cm") !== -1){
		//cm = height.split(/[\s]+/);
		print(JSON.stringify(person, null, 2));
		return 0;
	}
	numbers = height.split(/['\s/]+/);
	ft = parseFloat(numbers[0]);
	var cm = ft*FEET_RATIO; 
	//print("Pieds en cm : ", parseInt(Math.round(cm)))
	if (numbers.length == 2 && !isNaN(parseFloat(numbers[1]))){
		inch = parseFloat(numbers[1]);	
		cm +=Number(inch)*INCH_RATIO;
	}
	if (numbers.length == 4){
		inch = parseFloat(numbers[1])+parseFloat(numbers[2])/parseFloat(numbers[3]);
		cm +=Number(inch)*INCH_RATIO;
		//print(inch);
	}
	person.info.height = Math.round(cm).toString() + " cm ";
	if (cm >= 170.0){
		print(JSON.stringify(person, null, 2));
	}
	return 0;
	//print(height);
	//return height;
}
//print(usctosi("5' 1 1/4"))
