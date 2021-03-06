#!/usr/local/bin/perl
#
# fabrique des liens a partir du plan <h1>
open(IN,"<commands.html");
while (<IN>) {
	if (/^(.*)<\/h1>/) {
		print $1,"\n";
		push(@entry,$1);
	}
}
close(IN);
open(IN,"<commands.html");
open(OUT,">commands2.html");
$block = "rien";
print OUT "<h1><A HREF=macro.html>Jump to List of MACRO </A></h1>";
while (<IN>) {
	if (/<h1>/) {
		if ($block != "rien") {
			print OUT "</A>\n";
		}
		$_ = <IN>;
		/^(.*)<\/h1>/;
		$block = $1;
		print OUT "<A NAME=\"$block\">\n";
		print OUT "<h2>\n";
		print OUT "$block</h2>\n";
	}
	elsif (/see also/) {
	    $line = "see also :";
	    {
		foreach $ent (@entry) {
		    if (/[\s>,]$ent[\s<,]/) {
			$line = "$line <A HREF=\"#$ent\">$ent<\/A>";
		    }
		}
		if (/,$/) {
		    $_ = <IN>;
		    redo;
		}
	    }
	print OUT "$line <p>\n";
	}
	else {
	    print OUT $_;
	}
}

