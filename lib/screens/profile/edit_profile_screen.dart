import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfileScreen({super.key,required this.userData});

  @override
  State<EditProfileScreen> createState()=> _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen>{
  TextEditingController nameController=TextEditingController();
  TextEditingController bioController=TextEditingController();

  @override
  void initState(){
    super.initState();

    nameController.text=widget.userData["name"]??"";
    bioController.text=widget.userData["bio"]?? "";


  }
  Future<void> updateProfile()async{
    try{
      String? token=await TokenStorage.getToken();
      if(token==null)return;

      await ApiService.updateProfile(
        token,
        nameController.text,
        bioController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated")),

        );
        Navigator.pop(context);

    }catch(e){
      print("update error:$e");
    }
  }
  @override
  void dispose(){
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("edit profile"),
      ),
      body: Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          const SizedBox(height: 15,),
          TextField(
            controller: bioController,
            decoration: const InputDecoration(labelText: "Bio"),
          ),
          const SizedBox(height: 30),

          ElevatedButton(onPressed:updateProfile,
           child: const Text("Save"))
        ],
      ),
      ),
    );
  }

}