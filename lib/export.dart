import 'package:flutter/cupertino.dart';

export 'utils/colors.dart';
export 'utils/field.dart';
export 'utils/themes.dart';
export 'utils/buttons.dart';
export 'utils/images.dart';
export 'utils/grid.dart';
export 'utils/const.dart';

///Controllers///

export "controllers/textcontrollers.dart";

/// view ///
export 'views/authentication/signup.dart';
export 'views/authentication/otp.dart';
export 'views/authentication/addProfilepic.dart';
export 'views/report.dart';
export 'views/blood.dart';
export 'views/about_us.dart';
export 'views/notifications.dart';
export 'views/contact_us.dart';
export 'views/emergency.dart';
export 'views/main_screen.dart';
export 'views/viewprofile.dart';
export 'views/suppoters.dart';
export 'views/partners.dart';


///models///
export "models/user.dart";

height(double height) {
  return SizedBox(
    height: height,
  );
}

width(double w) {
  return SizedBox(
    width: w,
  );
}

hw(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}
