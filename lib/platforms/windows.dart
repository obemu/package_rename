part of package_rename;

void _setWindowsConfigurations(dynamic windowsConfig) {
  try {
    if (windowsConfig == null) return;
    if (windowsConfig is! Map) throw _PackageRenameErrors.invalidWindowsConfig;

    final windowsConfigMap = Map<String, dynamic>.from(windowsConfig);

    _setWindowsAppName(windowsConfigMap[_appNameKey]);
    _setWindowsOrganization(windowsConfigMap[_organizationKey]);
    _setWindowsCopyrightNotice(windowsConfigMap[_copyrightKey]);
    _setWindowsExecutableName(windowsConfigMap[_executableKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Skipping Windows configuration!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Windows configuration!!!');
  } finally {
    if (windowsConfig != null) _logger.w(_majorStepDoneLineBreak);
  }
}

void _setWindowsAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    _setWindowsAppTitle(appName);
    _setWindowsProductDetails(appName);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows App Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows App Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setWindowsAppTitle(String appName) {
  try {
    final mainCppFile = File(_windowsMainCppFilePath);
    if (!mainCppFile.existsSync()) {
      throw _PackageRenameErrors.windowsMainCppNotFound;
    }

    final mainCppString = mainCppFile.readAsStringSync();
    final newAppTitleMainCppString = mainCppString.replaceAll(
      RegExp(r'window.CreateAndShow\(L"(.*?)"'),
      'window.CreateAndShow(L"$appName"',
    );

    mainCppFile.writeAsStringSync(newAppTitleMainCppString);

    _logger.i('Windows app title set to: `$appName` (main.cpp)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows App Title change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows App Title change failed!!!');
  }
}

void _setWindowsProductDetails(String appName) {
  try {
    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newProductDetailsRunnerString = runnerString
        .replaceAll(
          RegExp(r'VALUE "FileDescription", "(.*?)"'),
          'VALUE "FileDescription", "$appName"',
        )
        .replaceAll(
          RegExp(r'VALUE "InternalName", "(.*?)"'),
          'VALUE "InternalName", "$appName"',
        )
        .replaceAll(
          RegExp(r'VALUE "ProductName", "(.*?)"'),
          'VALUE "ProductName", "$appName"',
        );

    runnerFile.writeAsStringSync(newProductDetailsRunnerString);

    _logger.i('Windows file description set to: `$appName` (Runner.rc)');
    _logger.i('Windows internal name set to: `$appName` (Runner.rc)');
    _logger.i('Windows product name set to: `$appName` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Product Details change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Product Details change failed!!!');
  }
}

void _setWindowsOrganization(dynamic organization) {
  try {
    if (organization == null) return;
    if (organization is! String) throw _PackageRenameErrors.invalidOrganization;

    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newOrganizationRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "CompanyName", "(.*?)"'),
      'VALUE "CompanyName", "$organization"',
    );

    runnerFile.writeAsStringSync(newOrganizationRunnerString);

    _logger.i('Windows company name set to: `$organization` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Organization change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Organization change failed!!!');
  } finally {
    if (organization != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setWindowsCopyrightNotice(dynamic notice) {
  try {
    if (notice == null) return;
    if (notice is! String) throw _PackageRenameErrors.invalidCopyrightNotice;

    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newCopyrightNoticeRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "LegalCopyright", "(.*?)"'),
      'VALUE "LegalCopyright", "$notice"',
    );

    runnerFile.writeAsStringSync(newCopyrightNoticeRunnerString);

    _logger.i('Windows legal copyright set to: `$notice` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Copyright Notice change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Copyright Notice change failed!!!');
  } finally {
    if (notice != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setWindowsExecutableName(dynamic exeName) {
  try {
    if (exeName == null) return;
    if (exeName is! String) throw _PackageRenameErrors.invalidExecutableName;

    final validExeNameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!validExeNameRegExp.hasMatch(exeName)) {
      throw _PackageRenameErrors.invalidExecutableNameValue;
    }

    _setWindowsCMakeListsBinaryName(exeName);
    _setWindowsOriginalFilename(exeName);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Executable Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Executable Name change failed!!!');
  } finally {
    if (exeName != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setWindowsCMakeListsBinaryName(String exeName) {
  try {
    final cmakeListsFile = File(_windowsCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.windowsCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newBinaryNameCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(BINARY_NAME "(.*?)"'),
      'set(BINARY_NAME "$exeName"',
    );

    cmakeListsFile.writeAsStringSync(newBinaryNameCmakeListsString);

    _logger.i('Windows binary name set to: `$exeName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Binary Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Binary Name change failed!!!');
  }
}

void _setWindowsOriginalFilename(String exeName) {
  try {
    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newOriginalFilenameRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "OriginalFilename", "(.*?)"'),
      'VALUE "OriginalFilename", "$exeName.exe"',
    );

    runnerFile.writeAsStringSync(newOriginalFilenameRunnerString);

    _logger.i('Windows original filename set to: `$exeName.exe` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Original Filename change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Original Filename change failed!!!');
  }
}
