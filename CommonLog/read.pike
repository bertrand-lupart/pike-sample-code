#!/usr/bin/env pike

                             /* Global variables */

// here is the path to the commonlog file
string commonlog_file="commonlog_sample.log";
// could be a Stdio.File object is you prefer

int commonlog_entries=0;

                            /* Script entry point*/

int main(int argc, array(string) argv)
{
  int start_offset = 0;

  // Here it is, open commonlog_file at offset start_offset and
  // invoque handle_commonlog_line() for each new line
  int bytes_read =
    CommonLog.read(handle_commonlog_line, commonlog_file, start_offset);

  // Sum up of what we did
  write("%d bytes read from %O, %d lines handled\n",
    bytes_read, commonlog_file, commonlog_entries);

  return 0;
}

                        /* Script-specific functions */

// for each valid commonlog line found, this function will be invoqued
void handle_commonlog_line(array commonlog_parts, int end_offset)
{
  // Do you fancy stuff here. We just print our data as an example
  
  write("-=-=-=-=-=-= entry : %O =-=-=-=-=-=-\n", commonlog_entries);
  write("    parts : %O\n", commonlog_parts);
  write("end offset: %O\n\n",end_offset);

  commonlog_entries++;

  return;
}
