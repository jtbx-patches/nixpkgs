{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "pypinyin";
  version = "0.53.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "mozillazg";
    repo = "python-pinyin";
    tag = "v${version}";
    hash = "sha256-NGW94Labk3vAv4bfq/+ba2lnL/uebg0ODZWEi2yNIjg=";
  };

  postPatch = ''
    substituteInPlace pytest.ini --replace \
      "--cov-report term-missing" ""
  '';

  nativeCheckInputs = [ pytestCheckHook ];

  pytestFlagsArray = [ "tests" ];

  meta = with lib; {
    description = "Chinese Characters to Pinyin - 汉字转拼音";
    mainProgram = "pypinyin";
    homepage = "https://github.com/mozillazg/python-pinyin";
    changelog = "https://github.com/mozillazg/python-pinyin/blob/v${version}/CHANGELOG.rst";
    license = licenses.mit;
    maintainers = teams.tts.members;
  };
}
