import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key = 'FIRST_TIME_OPEN';

class RatingService {
  late SharedPreferences _prefs;
  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> initService() async {
    await _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> checkOpenCount() async {
    int openCount = _prefs.getInt(key) ?? 0;
    openCount++;
    _prefs.setInt(key, openCount);
    return openCount == 3;
  }

  Future<bool> showRating() async {
    try {
      final available = await _inAppReview.isAvailable();
      if (available) {
        _inAppReview.requestReview();
      } else {
        _inAppReview.openStoreListing(
          appStoreId: "com.ainnovate.academiaii"
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error while showing rating: $e');
      return false;
    }
  }

  Future<void> initializeServicesAndChecking() async {
    await initService(); // Make sure to initialize the RatingService first.

    checkForRatingPrompt();
  }

  Future<void> checkForRatingPrompt() async {
    bool shouldShowReview = await checkOpenCount();
    if (shouldShowReview) {
      showRating();
    }
  }

}