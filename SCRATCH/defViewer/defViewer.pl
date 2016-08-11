#!/usr/bin/perl
my $numArg = @ARGV;
my $tcl_file = "";

if($ARGV[0] eq '-help' || $ARGV[0] eq '-HELP' || $ARGV[0] eq '-h' || $ARGV[0] eq 'H'){
   print "Usage:  ./defViewer -f <tcl file>\n";
   exit;
}

for(my $i=0; $i<$numArg; $i++){
    if($ARGV[$i] eq '-f'){$tcl_file = $ARGV[$i+1];}
}

##############  These two packages are most important #############
#perl2exe_include Tk::Bitmap ;
##perl2exe_exclude utf8_heavy.pl;
# for rpc need switch
use XML::SAX::PurePerl ; 
###################################################################
use Cwd;
use Benchmark;
use List::Util qw[min max];
use Tk;
use Tk::Widget;
use Tk::Pane;
use Tk::Entry;
use Tk::Frame;
use Tk::Scrollbar;
use Tk::Checkbutton;
use Tk::Radiobutton;
use Tk::DummyEncode;
use Tk::BrowseEntry;
use Tk::ROText;
use Tk::Photo;
use Tk::WorldCanvas;
use Tk::Optionmenu;
use Tk::Balloon;
use Tk::Adjuster;
###################################################################

my $BEEHOME = $ENV{SLVR_HOME};
if($BEEHOME eq ""){
   print "WARN: Please set your 'SLVR_HOME'....\n";
   exit;
}

require "${BEEHOME}/DB/make_GlobalVariableDB_package";

require "${BEEHOME}/DB/make_TechDB_package";
require "${BEEHOME}/DB/make_ViaDB_package";
require "${BEEHOME}/DB/make_ViaLayerDB_package";
require "${BEEHOME}/DB/make_ViaRuleDB_package";
require "${BEEHOME}/DB/make_ViaRuleLayerDB_package";
require "${BEEHOME}/DB/make_MacroDB_package";
require "${BEEHOME}/DB/make_MacroPinDB_package";

require "${BEEHOME}/DB/make_FloorplanDB_package";
require "${BEEHOME}/DB/make_CompDB_package";
require "${BEEHOME}/DB/make_PortDB_package";

require "${BEEHOME}/DB/make_NetDB_package";
require "${BEEHOME}/DB/make_NetAttribDB_package";
require "${BEEHOME}/DB/make_NetRoutingDB_package";

require "${BEEHOME}/DB/make_PinGuideDB_package";
require "${BEEHOME}/DB/make_MacroPinDB_package";
require "${BEEHOME}/DB/make_CompPinDB_package";

require "${BEEHOME}/DB/make_GCell_package";

require "${BEEHOME}/command_file";

require "${BEEHOME}/read_lef";
require "${BEEHOME}/read_def";
require "${BEEHOME}/make_gui";

################# setting global values ############
$GLOBAL = Global::new();
$GLOBAL->dbfGlobalSetDBU("2000");

#&read_lef(-lef, 'test/tsmc18_4lm.lef', -tech, also);
#&read_def(-def, 'test/s5378.def', '--all');
&initialize_commands;

if($tcl_file ne ""){
   &source($tcl_file);
   $tcl_file_found = 1;
}
#&win;
&start_gui;

