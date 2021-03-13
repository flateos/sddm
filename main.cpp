#include <QGuiApplication>
#include <QQmlContext>
#include <QQuickView>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQuickView view;
    view.setSource(QStringLiteral("qrc:/Main.qml"));

    QQmlContext* rootContext = view.rootContext();
    rootContext->setContextProperty("WINDOW_WIDTH", 680);
    rootContext->setContextProperty("WINDOW_HEIGHT", 440);

    view.show();

    return app.exec();
}
