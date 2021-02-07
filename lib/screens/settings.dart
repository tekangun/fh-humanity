import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:humantiy/core/services/location_services.dart';
import 'package:humantiy/models/air_data_model.dart';
import 'package:humantiy/theme/themeManager.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    alertDialog() {
      return Alert(
          type: AlertType.success,
          context: context,
          title: "KONUM BAŞARIYLA DEĞİŞTİRİLDİ",
          desc:
              "Konum değiştirme talebiniz başarıyla onaylandı.\nSağlıklı günler dileriz.",
          buttons: [
            DialogButton(
              child: Text(
                "KAPAT",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ]).show();
    }

    alertDialog2() {
      return Alert(
          type: AlertType.warning,
          context: context,
          title: "KONUM DEĞİŞTİRİLEMEDİ",
          desc:
              "Teknik bir sorun yaşandığından dolayı işleminizi gerçekleştiremedik.\nSağlıklı günler dileriz.",
          buttons: [
            DialogButton(
              child: Text(
                "KAPAT",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ]).show();
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.purple,
                        ),
                        title: Text('Change Location'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          LocationServices().getPosition().then((value) {
                            alertDialog();
                          }).catchError((e) {
                            alertDialog2();
                          });
                          //ardından bizim ana fonksiyona yollamamız gerekiyor sanırım.
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Other Settings',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => SwitchListTile(
                    activeColor: Colors.purple,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('Dark Mode'),
                    onChanged: (val) {
                      notifier.toggleTheme();
                    },
                    value: notifier.darkTheme,
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
