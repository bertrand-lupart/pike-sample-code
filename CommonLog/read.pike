#!/usr/bin/env pike

                             /* Global variables */

// here is the path to the commonlog file
string commonlog_file="commonlog_sample.log";
// alternatively, could be a Stdio.File object 
//object commonlog_file = Stdio.File("commonlog_sample.log", "r");

// Indexes for retrieving data from parts array
int index_remote_host = 0;
int index_ident_user = 1;
int index_auth_user = 2;
int index_year = 3;
int index_month = 4;
int index_day = 5;
int index_hours = 6;
int index_minutes = 7;
int index_seconds = 8;
int index_timezone = 9;
int index_method = 10;
int index_path = 11;
int index_protocol = 12;
int index_reply_code = 13;
int index_bytes = 14;


// keep a counter for the handled commonlog entries, for fun
int commonlog_entries=0;
// a counter for bytes served according to the logs, as an example 
int bytes_served = 0;



                            /* Script entry point*/

int main(int argc, array(string) argv)
{
  int start_offset = 0;

  // Here it is, open commonlog_file at offset start_offset and
  // invoke handle_commonlog_line() for each new line
  int logfile_bytes_read =
    CommonLog.read(handle_commonlog_line, commonlog_file, start_offset);

  // Sum up of what we did
  write("%d bytes read from %O, %d lines handled.\n%d bytes served.\n",
    logfile_bytes_read, commonlog_file, commonlog_entries, bytes_served);

  return 0;
}

                        /* Script-specific functions */

// for each valid commonlog line found, this function will be invoked
void handle_commonlog_line(array commonlog_parts, int end_offset)
{
  // Do you fancy stuff here. We just print our data as an example
  
  write("-=-=-=-=-=-= entry : %O =-=-=-=-=-=-\n", commonlog_entries);
  write("    parts : %O\n", commonlog_parts);
  write("end offset: %O\n\n",end_offset);

  // count how many lines we processed
  commonlog_entries++;

  // count how many bytes served according to the logs
  bytes_served += commonlog_parts[index_bytes];

  return;
}
