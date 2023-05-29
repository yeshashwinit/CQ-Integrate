public class JSONParserClass {

	public String x_id;
	public String Part_Name;
	public Integer Total_Quantity_Shipped;

	
	public static List<JSONParserClass> parse(String json) {
        json=json.replaceAll('"_id"', '"x_id"');
        json=json.replaceAll('"Part Name"', '"Part_Name"');
        json=json.replaceAll('"Total Quantity Shipped"', '"Total_Quantity_Shipped"');
		return (List<JSONParserClass>) System.JSON.deserialize(json, List<JSONParserClass>.class);
	}
}