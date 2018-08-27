// Copyright 2016 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/** CfMath: Constant Function Implementations of Mathematical Functions for HDL Elaboration
  *
  * This package contains a collection of mathematical functions that are commonly used when
  * defining the value of constants in HDL code.  These functions are implemented as Verilog
  * constants functions.  Introduced in Verilog 2001 (IEEE Std 1364-2001), a constant function
  * (§ 10.3.5) is a function whose value can be evaluated at compile time or during elaboration.
  * A constant function must be called with arguments that are constants.
  */

package automatic CfMath;

    /** Ceiled Division of Two Natural Numbers
      *
      * Returns the quotient of two natural numbers, rounded towards plus infinity.
      */

    function integer ceil_div;
        input integer dividend, divisor;
        integer remainder;
    begin

        // pragma translate_off
        if (dividend < 0)
            $fatal(1, "Dividend %0d is not a natural number!", dividend);

        if (divisor < 0)
            $fatal(1, "Divisor %0d is not a natural number!", divisor);

        if (divisor == 0) begin
            $fatal(1, "Division by zero!");
        end
        // pragma translate_on

        remainder = dividend;
        for (ceil_div = 0; remainder > 0; ceil_div = ceil_div+1)
            remainder = remainder - divisor;

    end endfunction

    /** Ceiled Binary Logarithm of a Natural Number
      *
      * Returns the binary logarithm (i.e., the logarithm to the base 2) of a natural number
      * (including 0), rounded towards plus infinity.
      *
      * Use this as drop-in replacement for the `$clog2` system function if the latter is not
      * supported by your toolchain.
      */

    function integer log2;
        input longint val;
    begin

        // pragma translate_off
        if (val < 0)
            $fatal(1, "Argument %0d is not a natural number!", val);
        // pragma translate_on

        val = val - 1;
        for (log2 = 0; val > 0; log2 = log2+1)
            val = val >> 1;

    end endfunction

endpackage
