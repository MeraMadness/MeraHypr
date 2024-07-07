const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#121f3a", /* black   */
  [1] = "#9476B8", /* red     */
  [2] = "#7587AD", /* green   */
  [3] = "#9B92B3", /* yellow  */
  [4] = "#A792CB", /* blue    */
  [5] = "#C5ACC2", /* magenta */
  [6] = "#DAA4DB", /* cyan    */
  [7] = "#eedee9", /* white   */

  /* 8 bright colors */
  [8]  = "#a69ba3",  /* black   */
  [9]  = "#9476B8",  /* red     */
  [10] = "#7587AD", /* green   */
  [11] = "#9B92B3", /* yellow  */
  [12] = "#A792CB", /* blue    */
  [13] = "#C5ACC2", /* magenta */
  [14] = "#DAA4DB", /* cyan    */
  [15] = "#eedee9", /* white   */

  /* special colors */
  [256] = "#121f3a", /* background */
  [257] = "#eedee9", /* foreground */
  [258] = "#eedee9",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
