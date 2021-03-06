test('T1969',
     [if_wordsize(32,
          compiler_stats_num_field('peak_megabytes_allocated', 13,
                                                               19)),
                             # expected value: 14 (x86/Windows 17/05/10)
                             #                 15 (x86/OS X)
                             #                 19 (x86/OS X)
      if_wordsize(64,
          compiler_stats_num_field('peak_megabytes_allocated', 24,
                                                               32)),
                                             # expected value: 28 (amd64/Linux)
                                             # expected value: 32 (amd64/Linux)
      if_wordsize(32,
          compiler_stats_num_field('max_bytes_used', 5000000,
                                                     7000000)),
                             # expected value: 6707308 (x86/OS X)
                             #                 5717704 (x86/Windows 17/05/10)
                             #                 6149572 (x86/Linux, 31/12/09)
      if_wordsize(64,
          compiler_stats_num_field('max_bytes_used',  9000000,
                                                     13000000)),
                                   # expected value: 11404664 (amd64/Linux)
      if_wordsize(32,
          compiler_stats_num_field('bytes allocated', 210000000,
                                                      270000000)),
                                    # expected value: 215582916 (x86/Windows)
                                    #                 221667908 (x86/OS X)
      if_wordsize(64,
          compiler_stats_num_field('bytes allocated', 420000000,
                                                      550000000)),
                                    # 17/11/2009:     434,845,560 (amd64/Linux)
                                    # 08/12/2009:     459,776,680 (amd64/Linux)
                                    # 17/05/2010:     519,377,728 (amd64/Linux)
      only_ways(['normal'])
      ],
     compile,
     [''])

# This one tests for the space leak in the native code generator,
# where it holds onto the entire asm output until the end.  The space
# leak reappears from time to time, so it's a good idea to have a test
# for it.  The residency of this test will jump by 10MB to 40MB or so
# on x86-64 if the space leak appears.

# Only run this one if we have an NCG:
if 'optasm' in config.compile_ways:
   conf_3294 = only_ways(['normal'])
else:
   conf_3294 = skip

test('T3294',
     [if_wordsize(32,
          compiler_stats_num_field('max_bytes_used', 12000000,
                                                     17000000)),
                                   # expected value: 13049060 (x86/Linux)
      if_wordsize(64,
          compiler_stats_num_field('max_bytes_used', 27000000,
                                                     34000000)),
                                   # expected value: 32 478 408 (amd64/Linux)
                                   # (but varies a lot, depending on when
                                   # we GC relative to the peak).
      if_wordsize(32,
          compiler_stats_num_field('bytes allocated', 650000000,
                                                      750000000)),
                                    # expected value: 815479800  (x86/Linux)
      if_wordsize(64,
          compiler_stats_num_field('bytes allocated', 1200000000,
                                                      1500000000)),
                                    # expected value: 1357587088 (amd64/Linux)
      conf_3294
      ],
     compile,
     [''])

test('T4801',
     [ # expect_broken(5224),
       # temporarily unbroken (#5227)
      # expected value: 11 (x86/OSX):
      if_wordsize(32,
          compiler_stats_num_field('peak_megabytes_allocated', 30, 40)),
      # expected value: 66 (amd64/Linux):
      if_wordsize(64,
          compiler_stats_num_field('peak_megabytes_allocated', 55, 70)),
      # expected value: 353463196 (x86/Windows)
      if_wordsize(32,
          compiler_stats_num_field('bytes allocated', 330000000,
                                                      370000000)),
      # expected value: 145038576 (amd64/Linux):
      if_wordsize(64,
          compiler_stats_num_field('bytes allocated', 600000000,
                                                      750000000)),
      # expected value: 14181360 (x86/Linux)
      if_wordsize(32,
          compiler_stats_num_field('max_bytes_used', 11000000,
                                                     14000000)),
      # expected value: 7001696 (amd64/Linux, bindist)
      # expected value: 7189848 (amd64/Linux, intree):
      if_wordsize(64,
          compiler_stats_num_field('max_bytes_used', 20000000,
                                                     30000000)),
       only_ways(['normal'])
      ],
     compile,
     [''])

test('T3064',
     [
      # expected value: 9 (x86/Linux 30-03-2011):
      if_wordsize(32,
          compiler_stats_num_field('peak_megabytes_allocated', 8, 11)),
      # expected value: 18 (amd64/Linux):
      if_wordsize(64,
          compiler_stats_num_field('peak_megabytes_allocated', 11, 16)),
      # expected value: 56380288 (x86/Linux) (28/6/2011)
      if_wordsize(32,
          compiler_stats_num_field('bytes allocated', 50000000,
                                                      60000000)),
      # expected value: 108937496 (amd64/Linux) (28/6/2011):
      if_wordsize(64,
          compiler_stats_num_field('bytes allocated', 100000000,
                                                      120000000)),
      # expected value: 2247016 (x86/Linux) (28/6/2011):
      if_wordsize(32,
          compiler_stats_num_field('max_bytes_used', 2000000,
                                                     3000000)),
      # expected value: 4032024 (amd64/Linux, intree) (28/6/2011):
      if_wordsize(64,
          compiler_stats_num_field('max_bytes_used', 3000000,
                                                     5000000)),
       only_ways(['normal'])
      ],
     compile,
     [''])

test('T4007',
     normal,
     run_command,
     ['$MAKE -s --no-print-directory T4007'])

test('T5030',
     [# expected value: 629864032 (x86/Darwin)
      if_wordsize(32,
          compiler_stats_num_field('bytes allocated', 600000000,
                                                      650000000)),
      # expected value: 1255998208 (amd64/Linux):
      if_wordsize(64,
          compiler_stats_num_field('bytes allocated', 1200000000,
                                                      1300000000)),
       only_ways(['normal'])
      ],
     compile,
     ['-fcontext-stack=300'])

