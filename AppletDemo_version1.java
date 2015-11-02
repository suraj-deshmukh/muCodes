import java.text.SimpleDateFormat;
import java.applet.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.RectangleInsets;
import java.applet.*;
public class AppletDemo extends JApplet implements ActionListener
{

	JButton Simulate;
	JTextField alpha,beta,gamma,delta,x,y,time,delta_time;
	JPanel j,k;
	JFreeChart chart,chart1;
	ChartPanel cp,cp1;
	int t=100,N;
	float a,b,g,d,prey[],pred[],dt;
	private void simulate()
	{
		for(int i=1;i<N;i++)
		{
			prey[i] = prey[i-1] + prey[i-1]*(a-  (b*pred[i-1]) )*dt;
			pred[i] = pred[i-1] + pred[i-1]*( (d*prey[i-1]) - g )*dt;
		}
	}
	public void init()
	{	
		setSize(2000,2000);
		setLayout(new  GridLayout(1,2));
		j = new JPanel();
		k = new JPanel();
		k.setLayout(new GridLayout(9,2));
		alpha = new JTextField("1.0");
		beta = new JTextField("1.2");
		gamma = new JTextField("4.0");
		delta = new JTextField("1.0");
		x = new JTextField("10");
		y = new JTextField("2");
		time = new JTextField("100");
		delta_time = new JTextField("0.01");
		Simulate = new JButton("Simulate");
		Simulate.addActionListener(this);
		k.add(new JLabel("Alpha",JLabel.CENTER));k.add(alpha);
		k.add(new JLabel("Beta",JLabel.CENTER));k.add(beta);
		k.add(new JLabel("Gamma",JLabel.CENTER));k.add(gamma);
		k.add(new JLabel("Delta",JLabel.CENTER));k.add(delta);
		k.add(new JLabel("X",JLabel.CENTER));k.add(x);
		k.add(new JLabel("Y",JLabel.CENTER));k.add(y);
		k.add(new JLabel("Time",JLabel.CENTER));k.add(time);
		k.add(new JLabel("Time Step",JLabel.CENTER));k.add(delta_time);
		k.add(Simulate);
		add(k);
        t=Integer.parseInt(time.getText());
        dt=Float.parseFloat(delta_time.getText());
        N=(int)(t/dt);
        prey = new float[N];
        pred = new float[N];
        prey[0] = Float.parseFloat(x.getText());
        pred[0] = Float.parseFloat(y.getText());
        a=Float.parseFloat(alpha.getText());
        b=Float.parseFloat(beta.getText());
        g=Float.parseFloat(gamma.getText());
        d=Float.parseFloat(delta.getText());
        simulate();
        j.setLayout(new GridLayout(2,1));
	   	chart = createChart(createDataset(),"prey predator vs Time","Time","Population"); 
	    cp = new ChartPanel(chart);
	    j.add(cp);
	   	chart1 = createChart(createDataset1(),"prey vs predator","prey","predator"); 
	    cp1 = new ChartPanel(chart1);
	    j.add(cp1);
	    add(j);	
	} 

	public void actionPerformed(ActionEvent ae)
	{
		String str=ae.getActionCommand();
        if(str.equals("Simulate"))
        {   
            t=Integer.parseInt(time.getText());
            dt=Float.parseFloat(delta_time.getText());
            N=(int)(t/dt);
            prey = new float[N];
            pred = new float[N];
            prey[0] = Float.parseFloat(x.getText());
            pred[0] = Float.parseFloat(y.getText());
            a=Float.parseFloat(alpha.getText());
            b=Float.parseFloat(beta.getText());
            g=Float.parseFloat(gamma.getText());
            d=Float.parseFloat(delta.getText());
            simulate();
 	   	   chart = createChart(createDataset(),"prey predator vs Time","Time","Population"); 
 	       cp = new ChartPanel(chart);
	   	   chart1 = createChart(createDataset1(),"prey vs predator","prey","predator"); 
	       cp1 = new ChartPanel(chart1);
	       j.removeAll();
	       j.add(cp);j.add(cp1);
           j.repaint();
           j.revalidate();
        }
	}

	
   private JFreeChart createChart(XYDataset dataset,String Title,String xlab,String ylab) {

	      JFreeChart xylineChart = ChartFactory.createXYLineChart(
	    	         Title ,
	    	         xlab ,
	    	         ylab ,
	    	         dataset ,
	    	         PlotOrientation.VERTICAL ,
	    	         true , true , false);
	    	         
	    	      ChartPanel chartpanel = new ChartPanel( xylineChart );
	    	      chartpanel.setPreferredSize( new java.awt.Dimension( 1000 , 1000) );
	    	      final XYPlot plot = xylineChart.getXYPlot( );
	    	      XYLineAndShapeRenderer renderer = new XYLineAndShapeRenderer( );
	    	      plot.setBackgroundPaint(Color.BLACK);
	  	          plot.setDomainCrosshairVisible(true);
		          plot.setRangeCrosshairVisible(true);
	    	      renderer.setSeriesPaint( 0 , Color.RED );
	    	      renderer.setSeriesPaint( 1 , Color.GREEN );
	    	     // renderer.setSeriesPaint( 2 , Color.YELLOW );
	    	      renderer.setSeriesStroke( 0 , new BasicStroke( 0f ) );
	    	      renderer.setSeriesStroke( 1 , new BasicStroke( 0f ) );
	    	     // renderer.setSeriesStroke( 2 , new BasicStroke( 2.0f ) );
	    	      plot.setRenderer( renderer ); 
	    	      return xylineChart;

    }

    private XYDataset createDataset() {

        XYSeries s1 = new XYSeries("Prey");
        for(int i=0;i<N;i++)
        	s1.add(i,prey[i]);


        XYSeries s2 = new XYSeries("Predator");
        for(int i=0;i<N;i++)
        	s2.add(i,pred[i]);


        XYSeriesCollection dataset = new XYSeriesCollection();
        dataset.addSeries(s1);
        dataset.addSeries(s2);

        return dataset;

    }
    private XYDataset createDataset1() {

        XYSeries s1 = new XYSeries("prey & predator");
        for(int i=0;i<N;i++)
        	s1.add(pred[i],prey[i]);
        XYSeriesCollection dataset = new XYSeriesCollection();
        dataset.addSeries(s1);

        return dataset;

    }
}
