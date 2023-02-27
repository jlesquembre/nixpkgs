{ lib
, stdenv
, fetchFromGitHub
, fetchgit
}:

projectInfo:

if lib.isPath projectInfo && (builtins.baseNameOf projectInfo == "info.json")

then

  let
    info = lib.importJSON projectInfo;
    projectSrc =
      if info.fetcher == "fetchFromGitHub" then fetchFromGitHub info.fetcherArgs
      else if info.fetcher == "fetchgit" then fetchgit info.fetcherArgs
      else abort "Invalid fetcher: ${info.fetcher}";

  in
  info // { src = projectSrc; }
else
  projectInfo
