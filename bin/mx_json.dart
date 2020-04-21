import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:xson_annotation/xson_annotation.dart';
import 'package:xson_builder/xson_builder.dart';
import 'package:named_mode/named_mode.dart';

main(List<String> args) {
  ArgParser parser = initArgParser();
  var result;
  try {
    result = parser.parse(args);
  } on Exception catch (e) {
    _handleArgError(parser, e.toString());
  }

  String jsonFile = result['file'];
  String output = result['output'];

  if (jsonFile == null || jsonFile.isEmpty) {
    stdout.write('-f: json檔案 為必填\n');
    return;
  }

  if (output == null || output.isEmpty) {
    stdout.write('-o: 輸出路徑 為必填\n');
    return;
  }

  XsonBuilder builder = XsonBuilder();

  String content = File(jsonFile).readAsStringSync();

  String filename = basename(output);
  String filepath = dirname(output);

  // 解析 output 路徑, 取得路徑以及檔案名稱
  File _ = builder.generateAndWriteFile(
    filepath,
    filename,
    content,
    handler: (String uniqueKey, String propertyName) {
      return PropertyRenameHandlers.concat([
        PropertyRenameHandlers.defaultHandler,
        (key, name) {
          return renameTo__anApple(name);
        },
      ])(uniqueKey, propertyName);
    },
  );
}

void _handleArgError(ArgParser parser, [String msg]) {
  if (msg != null) {
    stderr.write(msg);
  }
  stdout.write('使用參數:\n\t${parser.usage.replaceAll('\n', '\n\t')}\n');
  exit(1);
}

ArgParser initArgParser() {
  return ArgParser()
    ..addOption('file', abbr: 'f', help: '輸入json的檔案')
    ..addOption('output', abbr: 'o', help: '輸出反序列化model的完整路徑')
    ..addFlag('help', abbr: 'h', help: '幫助說明');
}
