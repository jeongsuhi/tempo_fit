
import 'package:flutter/material.dart';

enum Sound {
  maleVoiceDeep,
  electronicSound,
  none,
}

extension ThemesExtension on Sound {

  /// NOTE: 絶対に変更しないこと
  String get id {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "maleVoiceDeep";
      case Sound.electronicSound:
        return "electronicSound";
      case Sound.none:
        return "none";
    }
  }

  String get ready {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "sounds/maleVoiceDeep_ready.wav";
      case Sound.electronicSound:
        return "sounds/electronicSound_ready.wav";
      case Sound.none:
        return "";
    }
  }
  String get rest {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "sounds/maleVoiceDeep_rest.wav";
      case Sound.electronicSound:
        return "sounds/electronicSound_rest.wav";
      case Sound.none:
        return "";
    }
  }
  String get act {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "sounds/maleVoiceDeep_act.wav";
      case Sound.electronicSound:
        return "sounds/electronicSound_act.wav";
      case Sound.none:
        return "";
    }
  }
  String get half {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "sounds/maleVoiceDeep_half.wav";
      case Sound.electronicSound:
        return "";
      case Sound.none:
        return "";
    }
  }
  String get finish {
    switch (this) {
      case Sound.maleVoiceDeep:
        return "sounds/maleVoiceDeep_finish.wav";
      case Sound.electronicSound:
        return "sounds/electronicSound_finish.wav";
      case Sound.none:
        return "";
    }
  }

  IconData get icon {
    switch (this) {
      case Sound.maleVoiceDeep:
        return Icons.face;
      case Sound.electronicSound:
        return Icons.smart_toy_outlined;
      case Sound.none:
        return Icons.not_interested_outlined;
    }
  }
}