#!/usr/bin/env pike

/* This script shows the basics of MIME.Message() usage.
 *
 * It builds a simple text/plain message with an attached picture.
 *
 * Message is then sent using Protocols.SMTP.Client()
 */

int main(int argc, array(string) argv)
{
                         /* MIME message generation */

	// globals
	string addr_from = "from@example.com";
	array addr_to = ({ "to1@example.com", "to2@example.com" });
	array addr_cc = ({ "cc1@example.com", "cc2@example.com" });
	array addr_bcc = ({ "bcc1@example.com", "bcc2@example.com" });
	string host_smtp = "smtp.example.com";
  string path_attach = "/tmp/image.png";

	// mail data
	string head_subject = "Pike MIME.Message() example with attachment";
  string text_plain = "Please have a look at the attached image\n";
	string data_attach = Stdio.read_bytes(path_attach);

	// building basic MIME text part
	object mime_plain =
		MIME.Message(text_plain,
			([
				"content-transfer-encoding": "quoted-printable",
				"content-type": "text/plain; charset=utf-8;"
			])
		);
  // building basic MIME image attached
  // note that the image data is automatically encoded
	object mime_attach =
		MIME.Message(data_attach,
			([
				"content-type":"image/png",
				"content-disposition":"attachment;filename=image.png",
				"content-transfer-encoding":"base64"
			])
		);

	// main MIME message that will assemble to previously built MIME
  object mime_mail =
		MIME.Message("This is a multipart message in MIME format",
			([
				"MIME-Version":"1.0",
				"Subject":head_subject,
				"From":addr_from,
				"To":addr_to*",",
				"CC":addr_cc*",",
				"Date":Calendar.now()->format_smtp(),
			]),
			({ mime_plain, mime_attach  })
		);

                           /* Actually send email */

  // catch / throw is optional, added for the sake of completeness
	mixed err = catch{
    // MIME message is casted to string and sent via SMTP
    // note that cc and bcc recipient should be mentionned here
    Protocols.SMTP.Client(host_smtp)->send_message(addr_from,
      addr_to+addr_cc+addr_bcc, (string)mime_mail);
  };

  if(err)
  {
    throw( ({ "Can't send email\n", err }) );
  }

  return 0;
}
