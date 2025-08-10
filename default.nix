{ stdenv
, boost
, cmake
, fmt
, fetchFromGitHub
, gflags
, sqlite
, sqlitecpp
, utf8cpp
, pkg-config
, lib
}:
stdenv.mkDerivation rec {
  pname = "audacity-project-tools";
  version = "v1.0.4";
  src = fetchFromGitHub {
    owner = "audacity";
    repo = pname;
    rev = version;
    sha256 = "sha256-EouTTbTWrr0OD2RqppbF8ACHtGF83fhbLpQqTxYzWbg=";
  };
  preConfigure = ''
    install -v ${./CMakeLists.txt} CMakeLists.txt
  '';
  nativeBuildInputs = [ cmake ];
  buildInputs = [
    boost
    fmt
    gflags
    sqlite
    sqlitecpp
    utf8cpp
  ];
}

