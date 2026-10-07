# Main latexmk configuration
$pdf_mode = 1;                            # generate PDF, equivalent to -pdf
$aux_dir  = 'build/aux';                  # use separate directory for build artifacts
$bibtex_use = 2;                          # run bibtex/biber as needed, equivalent to -bibtex
$pdflatex = 'pdflatex -synctex=1 %O %S';  # enable synctex for pdflatex

# Load modules for file handling
use File::Find;
use File::Path qw(make_path);
use File::Spec;

# Pre-generate folders for .aux files when using aux_dir
sub make_aux_subdirs {
    return 0 if $aux_dir eq '' || $aux_dir eq '.';
    my %dirs;
    find(sub {
        return unless /\.tex$/;
        $dirs{$File::Find::dir} = 1;
    }, '.');
    make_path(File::Spec->catdir($aux_dir, $_)) for keys %dirs;
    return 0;
}

# add_hook() only exists in latexmk >= 4.84; older versions (e.g. Ubuntu's
# packaged latexmk) fall back to creating the folders once at startup
if (defined &add_hook) {
    add_hook('before_xlatex', \&make_aux_subdirs);
} else {
    make_aux_subdirs();
}

# Trigger makeglossaries when .glo or .acn files change
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

# run_makeglossaries: handles -auxdir/-outdir compatibility
# based on: https://tex.stackexchange.com/questions/58963/
sub run_makeglossaries {
  my ($base_name, $path) = fileparse( $_[0] );
  pushd $path;
  my $return = system "makeglossaries" . ($silent ? " -q" : "") . " $base_name";
  popd;
  return $return;
}

# Files to remove with 'latexmk -c'
push @generated_exts, 'glo', 'gls', 'glg';   # Glossaries
push @generated_exts, 'acn', 'acr', 'alg';   # Acronyms
push @generated_exts, 'lol', 'listing';      # List of listings and listings
push @generated_exts, 'run.xml', 'xmpdata';  # Metadata

$clean_ext .= ' %R.ist %R.xdy';              # Index style files

# Manually remove generated artifacts that don't use the document job name
if (defined &add_hook) {
    add_hook('cleanup', sub {
        unlink File::Spec->catfile($aux_dir, 'pdfa.xmpi');
        return 0;
    });
}
