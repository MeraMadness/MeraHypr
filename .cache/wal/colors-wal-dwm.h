static const char norm_fg[] = "#cccccc";
static const char norm_bg[] = "#040404";
static const char norm_border[] = "#8e8e8e";

static const char sel_fg[] = "#cccccc";
static const char sel_bg[] = "#717072";
static const char sel_border[] = "#cccccc";

static const char urg_fg[] = "#cccccc";
static const char urg_bg[] = "#605F60";
static const char urg_border[] = "#605F60";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
