class ProductDataModel{
  //data Type
  int? id;
  String? title;
  String? videoUrl;
  String? coverPicture;
// constructor
  ProductDataModel(
      {
        this.id,
        this.title,
        this.videoUrl,
        this.coverPicture
      }
      );
  //method that assign values to respective datatype vairables
  ProductDataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    title =json['title'];
    videoUrl = json['videoUrl'];
    coverPicture = json['coverPicture'];
  }
}