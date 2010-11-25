<?php defined('SYSPATH') OR die('No direct access allowed.');

class distance {

  /**
   * Get distance between coordinates in km
   *
   */
  public static function get_distance($lat1, $lon1, $lat2, $lon2) {
    /* WGS84 stuff */
    $a = 6378137;
    $b = 6356752.3142;
    $f = 1/298.257223563;
    /* end of WGS84 stuff */

    $L = deg2rad($lon2-$lon1);
    $U1 = atan((1-$f) * tan(deg2rad($lat1)));
    $U2 = atan((1-$f) * tan(deg2rad($lat2)));
    $sinU1 = sin($U1);
    $cosU1 = cos($U1);
    $sinU2 = sin($U2);
    $cosU2 = cos($U2);

    $lambda = $L;
    $lambdaP = 2*pi();
    $iterLimit = 20;
    while ((abs($lambda-$lambdaP) > pow(10, -12)) && ($iterLimit-- > 0)) {
      $sinLambda = sin($lambda);
      $cosLambda = cos($lambda);
      $sinSigma = sqrt(($cosU2*$sinLambda) * ($cosU2*$sinLambda) + ($cosU1*$sinU2-$sinU1*$cosU2*$cosLambda) * ($cosU1*$sinU2-$sinU1*$cosU2*$cosLambda));

      if ($sinSigma == 0) {
        return 0;
      }

      $cosSigma   = $sinU1*$sinU2 + $cosU1*$cosU2*$cosLambda;
      $sigma      = atan2($sinSigma, $cosSigma);
      $sinAlpha   = $cosU1 * $cosU2 * $sinLambda / $sinSigma;
      $cosSqAlpha = 1 - $sinAlpha*$sinAlpha;
      $cos2SigmaM = $cosSigma - 2*$sinU1*$sinU2/$cosSqAlpha;

      if (is_nan($cos2SigmaM)) {
        $cos2SigmaM = 0;
      }

      $C = $f/16*$cosSqAlpha*(4+$f*(4-3*$cosSqAlpha));
      $lambdaP = $lambda;
      $lambda = $L + (1-$C) * $f * $sinAlpha *($sigma + $C*$sinSigma*($cos2SigmaM+$C*$cosSigma*(-1+2*$cos2SigmaM*$cos2SigmaM)));
    }

    if ($iterLimit == 0) {
      // formula failed to converge
      return NaN;
    }

    $uSq = $cosSqAlpha * ($a*$a - $b*$b) / ($b*$b);
    $A = 1 + $uSq/16384*(4096+$uSq*(-768+$uSq*(320-175*$uSq)));
    $B = $uSq/1024 * (256+$uSq*(-128+$uSq*(74-47*$uSq)));
    $deltaSigma = $B*$sinSigma*($cos2SigmaM+$B/4*($cosSigma*(-1+2*$cos2SigmaM*$cos2SigmaM)- $B/6*$cos2SigmaM*(-3+4*$sinSigma*$sinSigma)*(-3+4*$cos2SigmaM*$cos2SigmaM)));

    return round($b*$A*($sigma-$deltaSigma) / 1000);


/* sphere way */
    $distance = rad2deg(acos(sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($lon1 - $lon2))));

    $distance *= 111.18957696; // Convert to km

    return $distance;
  }

}
