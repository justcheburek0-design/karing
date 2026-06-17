import 'package:flutter/material.dart';
import 'package:karing/app/utils/qrcode_utils.dart';
import 'package:karing/i18n/strings.g.dart';
import 'package:karing/screens/dialog_utils.dart';
import 'package:karing/screens/theme_config.dart';
import 'package:karing/screens/theme_define.dart';
import 'package:karing/screens/widgets/framework.dart';
import 'package:karing/screens/widgets/text_field.dart';

class TextToQrCodeScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routSettings() {
    return const RouteSettings(name: "TextToQrCodeScreen");
  }

  const TextToQrCodeScreen({super.key});

  @override
  State<TextToQrCodeScreen> createState() => _TextToQrCodeScreenState();
}

class _TextToQrCodeScreenState extends LasyRenderingState<TextToQrCodeScreen> {
  final _textController = TextEditingController();
  Image? _image;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeDefine.kColorBgPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_outlined, size: 24),
          ),
          title: Text(
            tcontext.meta.textToQrcode,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: ThemeConfig.kFontWeightTitle,
              fontSize: ThemeConfig.kFontSizeTitle,
              color: ThemeDefine.kColorOnSurface,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeDefine.kColorBgPrimary,
              ThemeDefine.kColorBgSecondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Column(
              children: [
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            child: TextFieldEx(
                              maxLines: 6,
                              textInputAction: TextInputAction.done,
                              controller: _textController,
                              decoration: const InputDecoration(
                                //  labelText: tcontext.TextToQrCodeScreen.content,
                                //  hintText: tcontext.TextToQrCodeScreen.contentHit,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                            child: SizedBox(
                              height: 45.0,
                              child: ElevatedButton(
                                child: Text(tcontext.meta.convert),
                                onPressed: () async {
                                  String text = _textController.text.trim();
                                  if (text.isEmpty) {
                                    _image = null;
                                  } else {
                                    var result = QrcodeUtils.toImage(text);
                                    if (result.error != null) {
                                      DialogUtils.showAlertDialog(
                                        context,
                                        result.error!.message,
                                        showCopy: true,
                                        showFAQ: true,
                                        withVersion: true,
                                      );
                                    } else {
                                      _image = result.data;
                                    }
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: _image,
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
