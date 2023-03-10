{ lib
, stdenv
, fetchurl
, fetchzip
, fetchsvn
, fetchgit
, fetchfossil
, fetchcvs
, fetchhg
, fetchFromGitea
, fetchFromGitHub
, fetchFromGitLab
, fetchFromGitiles
, fetchFromBitbucket
, fetchFromSavannah
, fetchFromRepoOrCz
, fetchFromSourcehut
}:

projectInfo:

if lib.isPath projectInfo && (builtins.baseNameOf projectInfo == "info.json")

then

  let
    info = lib.importJSON projectInfo;
    projectSrc =
      # if info.fetcher == "fetchFromGitHub" then fetchFromGitHub info.fetcherArgs
      # else if info.fetcher == "fetchgit" then fetchgit info.fetcherArgs
      if info.fetcher == "fetchurl" then fetchurl info.fetcherArgs
      else if info.fetcher == "fetchzip" then fetchzipinfo.fetcherArgs
      else if info.fetcher == "fetchsvn" then fetchsvninfo.fetcherArgs
      else if info.fetcher == "fetchgit" then fetchgitinfo.fetcherArgs
      else if info.fetcher == "fetchfossil" then fetchfossilinfo.fetcherArgs
      else if info.fetcher == "fetchcvs" then fetchcvsinfo.fetcherArgs
      else if info.fetcher == "fetchhg" then fetchhginfo.fetcherArgs
      else if info.fetcher == "fetchFromGitea" then fetchFromGiteainfo.fetcherArgs
      else if info.fetcher == "fetchFromGitHub" then fetchFromGitHubinfo.fetcherArgs
      else if info.fetcher == "fetchFromGitLab" then fetchFromGitLabinfo.fetcherArgs
      else if info.fetcher == "fetchFromGitiles" then fetchFromGitilesinfo.fetcherArgs
      else if info.fetcher == "fetchFromBitbucket" then fetchFromBitbucketinfo.fetcherArgs
      else if info.fetcher == "fetchFromSavannah" then fetchFromSavannahinfo.fetcherArgs
      else if info.fetcher == "fetchFromRepoOrCz" then fetchFromRepoOrCzinfo.fetcherArgs
      else if info.fetcher == "fetchFromSourcehut" then fetchFromSourcehutinfo.fetcherArgs
      else abort "Invalid fetcher: ${info.fetcher}";

  in
  info // { src = projectSrc; }
else
  projectInfo
