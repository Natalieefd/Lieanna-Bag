import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModeData = Provider.of<ThemeModeData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        title: Text(
          'SETTINGS',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text('Appearance',
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text('Theme',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeModeData.themeMode,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                Provider.of<ThemeModeData>(context, listen: false)
                    .changeTheme(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeModeData.themeMode,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                Provider.of<ThemeModeData>(context, listen: false)
                    .changeTheme(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeModeData.themeMode,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                Provider.of<ThemeModeData>(context, listen: false)
                    .changeTheme(value);
                Navigator.pop(context);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text('Color Scheme',
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          RadioListTile<int>(
            title: Text('Default'),
            value: 0,
            groupValue: themeModeData.selectedColorScheme,
            onChanged: (int? value) {
              if (value != null) {
                themeModeData.setColorScheme(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<int>(
            title: Text('Autumn'),
            value: 1,
            groupValue: themeModeData.selectedColorScheme,
            onChanged: (int? value) {
              if (value != null) {
                themeModeData.setColorScheme(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<int>(
            title: Text('Spring'),
            value: 2,
            groupValue: themeModeData.selectedColorScheme,
            onChanged: (int? value) {
              if (value != null) {
                themeModeData.setColorScheme(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<int>(
            title: Text('Winter'),
            value: 3,
            groupValue: themeModeData.selectedColorScheme,
            onChanged: (int? value) {
              if (value != null) {
                themeModeData.setColorScheme(value);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
