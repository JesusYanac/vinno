import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:common_ui/splash_screen.dart';

void main() {
  testWidgets('GIVEN default SplashScreen WHEN rendered THEN shows default text and style', (WidgetTester tester) async {
    // GIVEN - Configuración inicial
    const expectedText = 'MI APP';
    const expectedFontSize = 48.0;
    const expectedFontWeight = FontWeight.bold;
    
    // WHEN - Renderizamos el widget
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    // THEN - Verificamos los resultados esperados
    // Verificamos que se muestren los dos textos (base y relleno)
    expect(find.text(expectedText), findsNWidgets(2));
    
    // Verificamos el estilo del texto base
    final baseTextWidget = tester.widget<Text>(
      find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data == expectedText && 
                   widget.style?.color == Colors.grey[400]
      ).first
    );
    
    expect(baseTextWidget.style?.fontSize, expectedFontSize);
    expect(baseTextWidget.style?.fontWeight, expectedFontWeight);
  });

  testWidgets('GIVEN custom SplashScreen parameters WHEN rendered THEN shows custom text and style', (WidgetTester tester) async {
    // GIVEN - Configuración personalizada
    const customText = 'Custom App';
    const customColor = Colors.blue;
    const customFontSize = 32.0;
    
    // WHEN - Renderizamos el widget con parámetros personalizados
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(
          text: customText,
          fillColor: customColor,
          fontSize: customFontSize,
        ),
      ),
    );

    // THEN - Verificamos que se muestre el texto personalizado
    expect(find.text(customText), findsNWidgets(2));
    
    // Verificamos el estilo personalizado en el texto base
    final baseTextWidget = tester.widget<Text>(
      find.byWidgetPredicate(
        (widget) => widget is Text && 
                   widget.data == customText && 
                   widget.style?.color == Colors.grey[400]
      ).first
    );
    expect(baseTextWidget.style?.fontSize, customFontSize);
  });

  testWidgets('GIVEN SplashScreen with animation WHEN animation completes THEN widget remains visible', (WidgetTester tester) async {
    // GIVEN - Configuración de la animación
    const animationDuration = Duration(milliseconds: 500);
    
    // WHEN - Renderizamos el widget y esperamos a que la animación termine
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(
          animationDuration: animationDuration,
        ),
      ),
    );

    // Verificamos que los AnimatedBuilders estén presentes
    expect(find.byType(AnimatedBuilder), findsWidgets);

    // WHEN - Esperamos a que la animación termine
    await tester.pumpAndSettle(animationDuration * 2);

    // THEN - Verificamos que el widget siga visible después de la animación
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('GIVEN SplashScreen with custom text WHEN rendered THEN shows both base and fill text with correct styles', (WidgetTester tester) async {
    // GIVEN - Configuración de prueba
    const testText = 'Test App';
    const testFontSize = 24.0;
    const expectedFontWeight = FontWeight.bold;
    
    // WHEN - Renderizamos el widget con texto personalizado
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(
          text: testText,
          fontSize: testFontSize,
        ),
      ),
    );

    // THEN - Verificamos los widgets de texto
    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    
    // Debería haber dos widgets de texto (base y relleno)
    expect(textWidgets.length, 2);
    
    // Verificamos cada widget de texto
    for (final textWidget in textWidgets) {
      expect(textWidget.data, testText);
      expect(textWidget.style?.fontSize, testFontSize);
      expect(textWidget.style?.fontWeight, expectedFontWeight);
    }
    
    // Verificamos que uno sea el texto base (gris) y el otro el de relleno (blanco)
    final baseText = textWidgets.firstWhere(
      (widget) => widget.style?.color == Colors.grey[400],
      orElse: () => throw Exception('No se encontró el texto base (gris)')
    );
    
    final fillText = textWidgets.firstWhere(
      (widget) => widget.style?.color == Colors.white,
      orElse: () => throw Exception('No se encontró el texto de relleno (blanco)')
    );
    
    expect(baseText, isNotNull);
    expect(fillText, isNotNull);
  });

  testWidgets('GIVEN SplashScreen with empty text WHEN rendered THEN shows empty text without errors', (WidgetTester tester) async {
    // GIVEN - Texto vacío
    const emptyText = '';
    
    // WHEN - Renderizamos el widget con texto vacío
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(
          text: emptyText,
        ),
      ),
    );

    // THEN - Verificamos que el widget se renderice sin errores
    expect(find.byType(SplashScreen), findsOneWidget);
    // Verificamos que se muestre el texto vacío en ambos widgets
    expect(find.text(emptyText), findsNWidgets(2));
  });
}
