// w TIMER_0 i TIMER_3 odkomentuj to zadanie, które chcesz wykonać (jak np. chcesz 1 to odkomentuj zad1 w TIMER_0 i zad 1_2 w TIMER_3)

#include <c8051F060.h>

#define LED_DISPLAY_PORT 	P2
#define KEYBOARD_PORT		P3
#define DATABUS_PORT		P7
#define INT_BITS 4

void LatchDataBusValue (unsigned char);
void WatchDog_Init (void);
void Oscillator_Init(void);
void Timer3_Init(void);
void PORT_Init (void);
void Timer0_Init(void);
int leftRotate(int n, unsigned int d);
void zad1(void);
void zad2(void);
void zad3(void);
void zad1_2(void);
void zad3timer(void);

sfr16 RCAP3		= 0xCA;               // Timer3 reload value
sfr16 TMR3		= 0xCC;               // Timer3 counter
sfr16 TMR0    	= 0x8B;				  // Timer0 counter value

unsigned char i = 0;
unsigned char j;

sbit D_FLIP_FLOP_CLK = P5^6;

unsigned char DisplayPortValue = 0xFE;

volatile unsigned char port_value;

volatile unsigned char kc1 = 0;
volatile unsigned char kci = 16;
volatile unsigned char index = 0;
volatile unsigned char return_number = 0;
volatile unsigned int current_value = 0;

volatile unsigned char fixed_data_index[6] = {16, 16, 16, 16, 16, 16};
volatile unsigned char fixed_data_values[5];

volatile unsigned char nr_part = 0;

unsigned char global_counter = 0;

volatile unsigned char xdata led_display[18] = {
0x07, 0x7f, 0x6f, 0x71,
0x66, 0x6d, 0x7d, 0x79,
0x06, 0x5b, 0x4f, 0x5e,
0x3f, 0x77, 0x7c, 0x39,
0x00, 0x20
};

unsigned char code display[] = {0xFE, 0xFD, 0xFB, 0xF7, 0xFF, 0xDF};

volatile unsigned char diode_display = 0x20;

int main (void)
{
	WatchDog_Init ();
	Oscillator_Init ();
	Timer3_Init();
	Timer0_Init();
	PORT_Init ();

	EA = 1; //wlaczenie obslugi przerwan

	LatchDataBusValue (0x00);

	LED_DISPLAY_PORT = DisplayPortValue;

	SFRPAGE = CONFIG_PAGE;

	while(1);

	return 0;
}

//------------------------------------------------------------------------------------
// PORT_Init
//------------------------------------------------------------------------------------
//
// Configure the Crossbar and GPIO ports
//
void Timer0_Init(void)
{
	SFRPAGE   = TIMER01_PAGE;
	TMOD	 &= 0xF0;
	TMOD 	 |= 0x01;
	TMR0	  = 65535 - 50000;
	TCON	 |= 0x10;
	IE     	 |= 0x02;           // enable Timer0 interrupts
	SFRPAGE   = CONFIG_PAGE;
	return;
}

void TIMER0_ISR (void) interrupt 1
{
	char old_SFRPAGE;

	old_SFRPAGE = SFRPAGE;
	SFRPAGE	= TIMER01_PAGE;
	
	TMR0 = 65535 - 50000;

	//zad1();
	//zad2();
	//zad3();

	SFRPAGE = old_SFRPAGE;
	return;
}

void LatchDataBusValue (unsigned char DataBusValue)
{
	char	old_SFRPAGE;
	char	i = 0;

    old_SFRPAGE = SFRPAGE;
	SFRPAGE = CONFIG_PAGE;
	
	DATABUS_PORT = DataBusValue;

	D_FLIP_FLOP_CLK = 0;
    for (i = 0; i < 4; i++); 	
	D_FLIP_FLOP_CLK = 1;

	SFRPAGE = old_SFRPAGE;		
	return;
}

void WatchDog_Init (void)
{
	// disable watchdog timer
 	WDTCN = 0xde;
 	WDTCN = 0xad;	
	return;
}

void PORT_Init (void)
{
 	SFRPAGE   = CONFIG_PAGE;
	XBR2      = 0x40;			// Enable crossbar and weak pull-ups
	return;
}

void Timer3_Init(void)
{
	SFRPAGE   = TMR3_PAGE;
	RCAP3     = 65536-1000;     // Init reload values
	TMR3      = 0xffff;         // set to reload immediately
	TMR3CN    = 0x04;
  	TMR3CF    = 0x00;
	EIE2     |= 0x01;           // enable Timer3 interrupts
	SFRPAGE   = CONFIG_PAGE;
	return;
}

void Oscillator_Init(void)
{
    int i = 0;
    SFRPAGE   = CONFIG_PAGE;
    OSCXCN    = 0x67;
    for (i = 0; i < 3000; i++);  			// Wait 1ms for initialization
    while ((OSCXCN & 0x80) == 0);
    CLKSEL    = 0x01;
	return;
}

void TIMER3_ISR (void) interrupt 14
{
	char	old_SFRPAGE;

	TF3 = 0; //zerowanie flagi zgloszenia przerwania
    
	old_SFRPAGE = SFRPAGE;
	SFRPAGE   = CONFIG_PAGE;

	//zad1_2();
	//zad3timer();

	SFRPAGE = old_SFRPAGE;
	return;
}

void zad1(void)
{	

	char old_SFRPAGE;
	char s;

	old_SFRPAGE = SFRPAGE;
	SFRPAGE	= TIMER01_PAGE;

	TMR0 = 65535 - 10000;

	SFRPAGE = old_SFRPAGE;

	switch (P3){
	case 0xee:
		kci = 0;
		break;
	case 0xed:
		kci = 1;
		break;
	case 0xeb:
		kci = 2;
		break;
	case 0xe7:
		kci = 3;
		break;
	case 0xde:
		kci = 4;
		break;
	case 0xdd:
		kci = 5;
		break;
	case 0xdb:
		kci = 6;
		break;
	case 0xd7:
		kci = 7;
		break;
	case 0xbe:
		kci = 8;
		break;
	case 0xbd:
		kci = 9;
		break;
	case 0xbb:
		kci = 10;
		break;
	case 0xb7:
		kci = 11;
		break;
	case 0x7e:
		kci = 12;
		break;
	case 0x7d:
		kci = 13;
		break;
	case 0x7b:
		kci = 14;
		break;
	case 0x77:
		kci = 15;
		break;
	default:
		kci = 16;
		break;
	}

	s = (leftRotate(0xe, kc1) << 4) + 0xf;
	P3 = s;

	kc1++;
	if (kc1 == 4) {kc1 = 0;}	
}


void zad2(void)
{	
	char s;

	switch (P3){
	case 0xee:
		kci = 0;
		break;
	case 0xed:
		kci = 1;
		break;
	case 0xeb:
		kci = 2;
		break;
	case 0xe7:
		kci = 3;
		break;
	case 0xde:
		kci = 4;
		break;
	case 0xdd:
		kci = 5;
		break;
	case 0xdb:
		kci = 6;
		break;
	case 0xd7:
		kci = 7;
		break;
	case 0xbe:
		kci = 8;
		break;
	case 0xbd:
		kci = 9;
		break;
	case 0xbb:
		kci = 10;
		break;
	case 0xb7:
		kci = 11;
		break;
	case 0x7e:
		kci = 12;
		break;
	case 0x7d:
		kci = 13;
		break;
	case 0x7b:
		kci = 14;
		break;
	case 0x77:
		kci = 15;
		break;
	default:
		break;
	}


	s = (leftRotate(0xe, kc1) << 4) + 0xf;
	P3 = s;

	kc1++;
	if (kc1 == 4) {kc1 = 0;}	
}

void zad1_2(void)
{
	LED_DISPLAY_PORT = 0xFB;
	LatchDataBusValue (0x00);
	LatchDataBusValue (led_display[kci]);
}

void zad3(void)
{	
	char s;

	if (nr_part == 0){
		for (j = 0; j < 6; j++){
		fixed_data_index[j] = 16;
		}
	}

	switch (P3){
	case 0xee:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 0;
		fixed_data_values[nr_part] = 7;
		nr_part++;
		break;
	case 0xed:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 1;
		fixed_data_values[nr_part] = 8;
		nr_part++;
		break;
	case 0xeb:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 2;
		fixed_data_values[nr_part] = 9;
		nr_part++;
		break;
	case 0xde:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 4;
		fixed_data_values[nr_part] = 4;
		nr_part++;
		break;
	case 0xdd:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 5;
		fixed_data_values[nr_part] = 5;
		nr_part++;
		break;
	case 0xdb:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 6;
		fixed_data_values[nr_part] = 6;
		nr_part++;
		break;
	case 0xbe:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 8;
		fixed_data_values[nr_part] = 1;
		nr_part++;
		break;
	case 0xbd:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 9;
		fixed_data_values[nr_part] = 2;
		nr_part++;
		break;
	case 0xbb:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 10;
		fixed_data_values[nr_part] = 3;
		nr_part++;
		break;
	case 0xb7: //Return
		fixed_data_index[5] = 17;
		
		switch (nr_part){
		case 1:
			current_value = fixed_data_values[0];
			break;
		case 2:
			current_value = 10 * fixed_data_values[0] +
							fixed_data_values[1];
			break;
		case 3:
			current_value = 100 * fixed_data_values[0] + 
							10 * fixed_data_values[1] + 
							fixed_data_values[2];
			break;
		case 4:
			current_value = 1000 * fixed_data_values[0] + 
							100 * fixed_data_values[1] + 
							10 * fixed_data_values[2] + 
							fixed_data_values[3];
			break;
		default:
			break;
		}

		return_number++;

		break;
	case 0x7e:
		fixed_data_index[5] = 16;
		fixed_data_index[nr_part] = 12;
		fixed_data_values[nr_part] = 0;
		nr_part++;
		break;
	default:
		break;
	}
	


	s = (leftRotate(0xe, kc1) << 4) + 0xf;
	P3 = s;

	kc1++;
	if (kc1 == 4) {kc1 = 0;}
	
	if (nr_part == 5) nr_part = 0;

	if (return_number == 2) {
		return_number = 0;
		nr_part = 5;
	}
}

void zad3timer()
{
	LatchDataBusValue(0x00);
	LED_DISPLAY_PORT = display[index];
	LatchDataBusValue(led_display[fixed_data_index[index]]);

	index++;
	if (index == 6) index = 0;
}

int leftRotate(int n, unsigned int d)
{
    return ((n << d) | (n >> (INT_BITS - d))) & 0x0F;
}
