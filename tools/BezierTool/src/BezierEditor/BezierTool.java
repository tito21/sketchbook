/*
    Copyright 2008, 2009 Devon Rifkin

    This file is part of the Bezier Editor.

    The Bezier Editor is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    The Bezier Editor is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with the Bezier Editor.  If not, see <http://www.gnu.org/licenses/>.
 */

package BezierEditor;

import processing.app.*;
import processing.core.*;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Transferable;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import processing.app.Editor;
import processing.app.tools.Tool;

public class BezierTool implements Tool {
	Editor editor;
	JFrame frame;
	BezierApplet bezierApplet;

	JToggleButton penButton;
	JToggleButton selectorButton;
	JToggleButton splineSelectorButton;
	JToggleButton panButton;
	JButton fillButton;
	JButton generateCodeButton;
	JLabel xLocationLabel;
	JLabel yLocationLabel;

	boolean drawFill = false;

	// Are there better ways of writing these select functions? Sure.
	// But don't worry about it.
	void selectPen() {
		penButton.getModel().setSelected(true);
		penButton.getModel().setEnabled(false);
		selectorButton.getModel().setSelected(false);
		selectorButton.getModel().setEnabled(true);
		splineSelectorButton.getModel().setSelected(false);
		splineSelectorButton.getModel().setEnabled(true);
		panButton.getModel().setSelected(false);
		panButton.getModel().setEnabled(true);
		bezierApplet.bezierEditor.setMode(BezierEditor.PEN_MODE);
	}

	void selectSelector() {
		selectorButton.getModel().setSelected(true);
		selectorButton.getModel().setEnabled(false);
		penButton.getModel().setSelected(false);
		penButton.getModel().setEnabled(true);
		splineSelectorButton.getModel().setSelected(false);
		splineSelectorButton.getModel().setEnabled(true);
		panButton.getModel().setSelected(false);
		panButton.getModel().setEnabled(true);
		bezierApplet.bezierEditor.setMode(BezierEditor.SELECTOR_MODE);
	}

	void selectSplineSelector() {
		splineSelectorButton.getModel().setSelected(true);
		splineSelectorButton.getModel().setEnabled(false);
		penButton.getModel().setSelected(false);
		penButton.getModel().setEnabled(true);
		selectorButton.getModel().setSelected(false);
		selectorButton.getModel().setEnabled(true);
		panButton.getModel().setSelected(false);
		panButton.getModel().setEnabled(true);
		bezierApplet.bezierEditor.setMode(BezierEditor.SPLINE_SELECTOR_MODE);
	}

	void selectPan() {
		panButton.getModel().setSelected(true);
		panButton.getModel().setEnabled(false);

		selectorButton.getModel().setSelected(false);
		selectorButton.getModel().setEnabled(true);
		splineSelectorButton.getModel().setSelected(false);
		splineSelectorButton.getModel().setEnabled(true);
		penButton.getModel().setSelected(false);
		penButton.getModel().setEnabled(true);
		bezierApplet.bezierEditor.setMode(BezierEditor.PAN_MODE);
	}


	// TODO: break this function up
	// It's so messy because I was learning basic Java UI when I wrote the
	// first version of it.  Haven't taken the time to split it up yet.
	public void init(Editor editor) {
		this.editor = editor;
		
		frame = new JFrame("Bezier Editor");
		frame.getContentPane().setLayout(new BorderLayout());

		frame.setFocusable(true);


		Box box = Box.createVerticalBox();
		box.setBorder(new EmptyBorder(12, 12, 12, 12));

		bezierApplet = new BezierApplet(this);
		bezierApplet.init();
		
		
		
		Box modeBox = Box.createHorizontalBox();
		modeBox.setAlignmentY(0);
				
		ActionListener actionListener = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (penButton == e.getSource() && penButton.getModel().isSelected()) {
					frame.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
					
					selectPen();
				} else if (selectorButton == e.getSource() && selectorButton.getModel().isSelected()) {
					frame.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
										
					selectSelector();
				} else if (splineSelectorButton == e.getSource() && splineSelectorButton.getModel().isSelected()) {
					frame.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
					
					selectSplineSelector();
				} else if (panButton == e.getSource() && panButton.getModel().isSelected()) {
					frame.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
					
					selectPan();
				} else if (generateCodeButton == e.getSource()) {
					copyToClipboard(bezierApplet.bezierEditor.generateCode());
				} else if (fillButton == e.getSource()) {
						String text;
						if (drawFill == false) {
								drawFill = true;
								text = "Hide fill";
						} else {
								drawFill = false;
								text = "Draw fill";
						}

						bezierApplet.bezierEditor.setDrawFill(drawFill);
						fillButton.setText(text);
				}
			}
		};

		fillButton = new JButton("Draw fill");
		fillButton.addActionListener(actionListener);
		
		penButton = new JToggleButton("Draw (d)", true);
		penButton.addActionListener(actionListener);
		penButton.getModel().setEnabled(false);
		//penButton.setActionCommand("penButton");
		
		selectorButton = new JToggleButton("Select Point (s)", false);
		selectorButton.addActionListener(actionListener);

		
		splineSelectorButton = new JToggleButton("Select Curve (c)", false);
		splineSelectorButton.addActionListener(actionListener);
		
		panButton = new JToggleButton("Pan Screen (a)", false);
		panButton.addActionListener(actionListener);


		// Set up the keyboard shortcuts for the buttons:
		
		// Why do I set up the shortcuts both here and in the applet?
		// The applet steals focus, and even "WHEN_IN_FOCUSED_WINDOW" doesn't
		// work.  Probably going to rewrite the applet parts with swing anyway.
		// If anyone knows a better way, let me know... that is, if anyone
		// actually reads any of this...
		String SHORTCUT_ACTION_KEY = "Shortcut Action";

		penButton.getActionMap().put(SHORTCUT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					penButton.doClick();
				}}
		);
		penButton.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke('d'), SHORTCUT_ACTION_KEY);

		selectorButton.getActionMap().put(SHORTCUT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					selectorButton.doClick();
				}}
		);
		selectorButton.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke('s'), SHORTCUT_ACTION_KEY);


		splineSelectorButton.getActionMap().put(SHORTCUT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					splineSelectorButton.doClick();
				}}
		);
		splineSelectorButton.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke('c'), SHORTCUT_ACTION_KEY);

		panButton.getActionMap().put(SHORTCUT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					panButton.doClick();
				}}
		);
		panButton.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke('a'), SHORTCUT_ACTION_KEY);


		String LEFT_ACTION_KEY = "Left Action";
		String RIGHT_ACTION_KEY = "Right Action";
		String UP_ACTION_KEY = "Up Action";
		String DOWN_ACTION_KEY = "Down Action";


		box.getActionMap().put(LEFT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.codedKeyPressed(PApplet.LEFT);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_LEFT, 0), LEFT_ACTION_KEY);


		box.getActionMap().put(RIGHT_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.codedKeyPressed(PApplet.RIGHT);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_RIGHT, 0), RIGHT_ACTION_KEY);


		box.getActionMap().put(UP_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.codedKeyPressed(PApplet.UP);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_UP, 0), UP_ACTION_KEY);


		box.getActionMap().put(DOWN_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.codedKeyPressed(PApplet.DOWN);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_DOWN, 0), DOWN_ACTION_KEY);



		String DELETE_ACTION_KEY = "Delete Action";

		box.getActionMap().put(DELETE_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.keyPressed(PApplet.DELETE);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_DELETE, 0), DELETE_ACTION_KEY);

		String BACKSPACE_ACTION_KEY = "Backspace Action";

		box.getActionMap().put(BACKSPACE_ACTION_KEY,
			new AbstractAction() {
				public void actionPerformed(ActionEvent e) {
					bezierApplet.bezierEditor.keyPressed(PApplet.BACKSPACE);
				}}
		);
		box.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW)
				.put(KeyStroke.getKeyStroke(KeyEvent.VK_BACK_SPACE, 0), BACKSPACE_ACTION_KEY);


		final int BUTTON_SPACING = 5;

		modeBox.add(penButton);
		modeBox.add(Box.createHorizontalStrut(BUTTON_SPACING));
		modeBox.add(selectorButton);
		modeBox.add(Box.createHorizontalStrut(BUTTON_SPACING));
		modeBox.add(splineSelectorButton);
		modeBox.add(Box.createHorizontalStrut(BUTTON_SPACING));
		modeBox.add(panButton);
		modeBox.add(Box.createHorizontalGlue());
		


		
		modeBox.add(Box.createVerticalStrut(10));


		Box locationBox = Box.createHorizontalBox();
		locationBox.add(Box.createHorizontalGlue());

		xLocationLabel = new JLabel("0", SwingConstants.RIGHT);
		yLocationLabel = new JLabel("0", SwingConstants.RIGHT);

		xLocationLabel.setPreferredSize(new Dimension(36, xLocationLabel.getHeight()));
		yLocationLabel.setPreferredSize(new Dimension(36, yLocationLabel.getHeight()));
		
		locationBox.add(new JLabel("x: "));
		locationBox.add(xLocationLabel);
		locationBox.add(Box.createHorizontalStrut(25));
		locationBox.add(new JLabel("y: "));
		locationBox.add(yLocationLabel);

		Box actionBox = Box.createHorizontalBox();
		actionBox.add(fillButton);


		actionBox.add(Box.createHorizontalGlue());
		generateCodeButton = new JButton("Copy code to clipboard");
		actionBox.add(generateCodeButton);
		
		generateCodeButton.addActionListener(actionListener);

		box.add(modeBox);
		box.add(Box.createVerticalStrut(4));
		box.add(bezierApplet);
		box.add(Box.createVerticalStrut(4));
		box.add(locationBox);
		box.add(Box.createVerticalStrut(4));
		box.add(actionBox);


		frame.getContentPane().add(box, BorderLayout.CENTER);
		frame.pack();
		frame.setResizable(false);
		
		Dimension size = frame.getSize();
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		frame.setLocation((screen.width - size.width) / 2,
											(screen.height - size.height) / 2);

		frame.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
				public void windowClosing(WindowEvent e) {
					frame.setVisible(false);
				}
			});
		Base.registerWindowCloseKeys(frame.getRootPane(), new ActionListener() {
				public void actionPerformed(ActionEvent actionEvent) {
					frame.setVisible(false);
				}
			});
		Base.setIcon(frame);
	}
	
	public String getMenuTitle() {
			return "Bezier Editor";
	}
	
	public void run() {
		 frame.setVisible(true);
	}
	
	
	void insertCode() {
		editor.insertText(bezierApplet.bezierEditor.generateCode());
	}

	void copyToClipboard(String s) {
		Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
		Transferable text = new StringSelection(s);
		clipboard.setContents(text, null);
	}

	public void keyTyped(KeyEvent e) {
		return;
	}

	public void updateLocation(float x, float y) {
		xLocationLabel.setText(String.format("%.0f", x));
		yLocationLabel.setText(String.format("%.0f", y));
	}
}