test('cg001', only_compiler_types(['ghc']), compile, [''])
test('cg002', normal, compile, [''])
test('cg003', only_ways(['optasm']), compile, [''])
test('cg004', normal, compile, [''])
test('cg005', only_ways(['optasm']), compile, [''])
test('cg006', normal, compile, [''])
test('cg007', normal, compile, [''])
test('cg008', normal, compile, [''])

test('1916', normal, compile, [''])
test('2388', normal, compile, [''])
test('3132', normal, compile, ['-dcmm-lint'])
test('T3286', extra_clean(['T3286b.o','T3286b.hi']), 
              multimod_compile, ['T3286', '-v0'])
test('3579', normal, compile, [''])
test('2578', normal, run_command, ['$MAKE -s --no-print-directory 2578'])
# skip llvm on i386 as we don't support fPIC
test('jmp_tbl', if_arch('i386', omit_ways(['llvm', 'optllvm'])), compile, ['-fPIC -O'])
test('massive_array', if_arch('i386', omit_ways(['llvm', 'optllvm'])), compile, ['-fPIC'])
