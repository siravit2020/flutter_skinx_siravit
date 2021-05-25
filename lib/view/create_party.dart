import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/constants/type_text_field.dart';
import 'package:flutter_skinx_siravit/providers/create_party_provider.dart';
import 'package:flutter_skinx_siravit/providers/register_provicer.dart';
import 'package:flutter_skinx_siravit/widgets/fill_button.dart';
import 'package:flutter_skinx_siravit/widgets/violet_corner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreatePartyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VioletCornerWidget(
      title: 'สร้างปาร์ตี้',
      widget: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 40,
          ),
          PartyName(),
          SizedBox(
            height: 20,
          ),
          _TiTleWidget(
            iconData: Icons.collections_outlined,
            title: 'เพิ่มรูปภาพปาร์ตี้ (เพื่อให้ดูน่าสนใจมากยิ่งขึ้น)',
          ),
          _AddImage(),
          SizedBox(
            height: 15,
          ),
          _TiTleWidget(
            iconData: Icons.campaign_outlined,
            title: 'เพิ่มรายระเอียดเกี่ยวกับปาร์ตี้',
          ),
          SizedBox(
            height: 20,
          ),
          _TextFieldDescription(),
          SizedBox(
            height: 20,
          ),
          _TiTleWidget(
            iconData: Icons.groups_outlined,
            title: 'ระบุจำนวณสมาชิกที่ต้องการ (ไม่รวมผู้สร้างปาร์ตี้)',
          ),
          _CountMember(),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
                shape: StadiumBorder(),
                side: BorderSide(color: colorViolet),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              child: Text(
                'สร้างปาร์ตี้',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: colorViolet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createPartyProvider =
        context.read<CreatePartyChnageNotifierProvider>();
    return Row(
      children: [
        _MemberItem(count: 1),
        _MemberItem(count: 2),
        _MemberItem(count: 3),
        _MemberItem(count: 4),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Focus(
              onFocusChange: (value) {
                String text = createPartyProvider.memberController.text;
                if (text.isNotEmpty) {
                  int count = int.parse(text);
                  createPartyProvider.countMember = count;
                  if (count <= 4) createPartyProvider.setMember = '';
                }
              },
              child: TextFormField(
                controller: createPartyProvider.memberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MemberItem extends StatelessWidget {
  final int count;

  const _MemberItem({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    context.select((CreatePartyChnageNotifierProvider c) => c.countMember);
    final countMember =
        context.read<CreatePartyChnageNotifierProvider>().countMember;
    return GestureDetector(
      onTap: () {
        context.read<CreatePartyChnageNotifierProvider>().countMember = count;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: (countMember == count) ? colorViolet : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$count',
          style: theme.bodyText1!.copyWith(
            color: (countMember == count) ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ),
    );
  }
}

class _TextFieldDescription extends StatelessWidget {
  const _TextFieldDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createPartyProvider =
        context.read<CreatePartyChnageNotifierProvider>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: createPartyProvider.descriptionController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 4,
        maxLength: 300,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}

class _AddImage extends StatelessWidget {
  const _AddImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image =
        context.select((CreatePartyChnageNotifierProvider c) => c.image);
    return Column(
      children: [
        image != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(image),
                ),
              )
            : SizedBox(
                height: 10,
              ),
        _AddImageButton(),
      ],
    );
  }
}

class _TiTleWidget extends StatelessWidget {
  final IconData iconData;
  final String title;

  const _TiTleWidget({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(iconData),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: theme.bodyText2,
          ),
        ),
      ],
    );
  }
}

class PartyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final createPartyProvider =
        context.read<CreatePartyChnageNotifierProvider>();
    final error =
        context.select((CreatePartyChnageNotifierProvider c) => c.error);
    return Column(
      children: [
        _TiTleWidget(
          iconData: Icons.edit_outlined,
          title: 'ตั้งชื่อปาร์ตี้',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextFormField(
                  controller: createPartyProvider.partyNameController,
                  onChanged: (value) {
                    if (error) createPartyProvider.error = false;
                  },
                  maxLength: 60,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
              if (error)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      'กรุณาตั้งชื่อปาร์ตี้',
                      style: theme.bodyText1!.copyWith(color: colorRed),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddImageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createPartyProvider =
        context.read<CreatePartyChnageNotifierProvider>();
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final imageFile = await _pickImage();
          if (imageFile != null) createPartyProvider.image = imageFile;
        },
        style: ElevatedButton.styleFrom(
          primary: colorViolet,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_camera_outlined),
            SizedBox(
              width: 10,
            ),
            Text(
              'เพิ่มรูปภาพ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _pickImage() async {
    File? file;
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    file = pickedImage != null ? File(pickedImage.path) : null;
    if (file != null) {
      return await _cropImage(file);
    }
    return null;
  }

  Future<File?> _cropImage(File? file) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: file!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.original,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      return croppedFile;
    }
    return null;
  }
}
