#!/usr/bin/env pike

int main(int argc, array(string) argv)
{
												 /* MIME message generation */

	// globals
	string addr_from = "from@example.com";
	string addr_to = "to@example.com";
	string host_smtp = "smtp.example.com";
  string path_attach = "/tmp/image.png";

	// mail data
	string head_subject = "Pike MIME.Message attachment";
  string text_plain = "Please find this image as attachment\n";
	string data_attach = Stdio.read_bytes(path_attach);

	// building MIME parts
	object mime_plain =
		MIME.Message(text_plain,
			([
				"content-transfer-encoding": "quoted-printable",
				"content-type": "text/plain; charset=utf-8;"
			])
		);
	object mime_attach =
		MIME.Message(data_attach,
			([
				"content-type":"image/png",
				"content-disposition":"attachment;filename=image.png",
				"content-transfer-encoding":"base64"
			])
		);

	// main MIME part	
  object mime_mail =
		MIME.Message("This is a multipart message in MIME format",
			([
				"MIME-Version":"1.0",
				"Subject":head_subject,
				"From":addr_from,
				"To":addr_to,
				"Date":Calendar.now()->format_smtp(),
			]),
			({ mime_plain, mime_attach  })
		);

                           /* Actually send email */

	Protocols.SMTP.Client(host_smtp)->send_message(addr_from,
      ({ addr_to }), (string)mime_mail);

  return 0;
}
