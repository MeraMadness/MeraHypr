static const char norm_fg[] = "#eedee9";
static const char norm_bg[] = "#121f3a";
static const char norm_border[] = "#a69ba3";

static const char sel_fg[] = "#eedee9";
static const char sel_bg[] = "#7587AD";
static const char sel_border[] = "#eedee9";

static const char urg_fg[] = "#eedee9";
static const char urg_bg[] = "#9476B8";
static const char urg_border[] = "#9476B8";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
