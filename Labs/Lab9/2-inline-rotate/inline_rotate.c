#include <stdio.h>

#define NUM	0x12345678

int main(void)
{
	size_t n = NUM;
	size_t rot_left;
	size_t rot_right;

	__asm__ (
	/* TODO: Use rol instruction to shift n by 8 bits left.
	 * Place result in rot_left variable.
	 */
	"mov eax, %2\n\t"
    "rol eax, 8\n\t"
    "mov %0, eax\n\t"
	/* TODO: Use ror instruction to shift n by 8 bits right.
	 * Place result in rot_right variable.
	 */
    "mov eax, %2\n\t"
    "ror eax, 8\n\t"
    "mov %1, eax\n\t"
	/* TODO: Declare output variables - preceded by ':'. */
	/* TODO: Declare input variables - preceded by ':'. */
	/* TODO: Declared used registers - preceded by ':'. */
    : "=r" (rot_left), "=r" (rot_right)
    : "r" (n)
	: "eax" );

	/* NOTE: Output variables are passed by address, input variables
	 * are passed by value.
	 */

	printf("init: 0x%08x, rot_left: 0x%08x, rot_right: 0x%08x\n",
			n, rot_left, rot_right);

	return 0;
}
