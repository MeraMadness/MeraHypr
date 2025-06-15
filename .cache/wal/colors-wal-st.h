const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#040404", /* black   */
  [1] = "#605F60", /* red     */
  [2] = "#717072", /* green   */
  [3] = "#798358", /* yellow  */
  [4] = "#807F80", /* blue    */
  [5] = "#929293", /* magenta */
  [6] = "#A09F9F", /* cyan    */
  [7] = "#cccccc", /* white   */

  /* 8 bright colors */
  [8]  = "#8e8e8e",  /* black   */
  [9]  = "#605F60",  /* red     */
  [10] = "#717072", /* green   */
  [11] = "#798358", /* yellow  */
  [12] = "#807F80", /* blue    */
  [13] = "#929293", /* magenta */
  [14] = "#A09F9F", /* cyan    */
  [15] = "#cccccc", /* white   */

  /* special colors */
  [256] = "#040404", /* background */
  [257] = "#cccccc", /* foreground */
  [258] = "#cccccc",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
